# frozen_string_literal: true
require 'fileutils'
require 'stackprof'
require 'validate/config'

class Check
  attr_reader :opts, :count, :msgs, :started, :total, :queue

  def initialize(opts)
    @opts = opts
    @count = 0
    @msgs = 0
    @queue = Queue.new
  end

  def run
    clear_all if clear_all?
    Travis::Yml.expand
    records = scope.all.to_a
    @started = Time.now
    @total = records.size
    puts "Found #{total} configs to check."

    # StackProf.run(mode: :cpu, out: 'tmp/stackprof-cpu-myapp.dump') do
      records.each do |request|
        check(request)
      end
    # end
  end

  def check(request)
    @count += 1
    # p request.id
    # puts request.config
    config = Config.new(request)
    msgs = config.msgs
    store(request, msgs)
    @msgs += msgs.size
    request.update_attributes(checked: true)
    summary? ? summary(request, msgs, config) : status
  end

  def status
    sec     = per_config.round(3).to_s.ljust(5, '0')
    started = self.started.strftime('%H:%M')
    eta     = self.eta.strftime('%H:%M')
    elapsed = self.elapsed.strftime('%H:%M:%S')
    pending = total - count
    left    = Time.at(per_config * (total - count)).utc.strftime('%H:%M:%S')
    print "\r\e[2K#{count} configs evaluated, #{pending} to go. #{msgs} messages. #{sec}s per config. Started #{started}, elapsed #{elapsed}, left #{left}, ETA #{eta}."
  end

  def per_config
    time = Time.now - started
    time / count
  end

  def elapsed
    sec = Time.now - started
    Time.at(sec).utc
  end

  def eta
    sec = per_config * (total - count)
    Time.now + sec
  end

  def summary?
    opts[:details]
  end

  def summary(request, msgs, config)
    puts "\nRepo:"
    puts request.repo_id
    puts "\nYaml:"
    puts request.config
    puts "\nMessages:"
    msgs.each { |msg| p msg }
    puts "\nResult:"
    puts config.to_hash rescue nil
  end

  def store(request, msgs)
    Record::Message.where(request_id: request.id).delete_all unless ids.empty?
    msgs.each { |msg| store_msg(request, msg) }
  end

  def store_msg(request, msg)
    Record::Message.create!(
      repo_id: request.repo_id,
      request_id: request.id,
      level: msg[0],
      key: msg[1],
      code: msg[2],
      args: msg[3]
    )
  end

  def clear_all
    puts "Clearing all previous results"
    # Dir['var/msgs/*'].each { |path| FileUtils.rm(path) }
    Record::Request.update_all(checked: nil)
    Record::Message.delete_all
    Record::Message.connection.execute('ALTER SEQUENCE messages_id_seq RESTART WITH 1;')
  end

  # def clear
  #   puts "Clearing previous results"
  #   Record::Message.where(request_id: ids).delete_all
  # end

  def scope
    scope = Record::Request
    # scope = scope.where('id not in (?)', Local::Msg.select(:request_id).distinct.map(&:request_id)) unless clear?
    scope = ids.empty? ? scope.where(checked: nil) : scope.where(id: ids)
    scope = scope.limit(opts[:count]) if opts[:count]
    scope
  end

  def clear_all?
    !!opts[:clean] && ids.empty?
  end

  def clear?
    !ids.empty?
  end

  def ids
    opts[:ids] || []
  end
end
