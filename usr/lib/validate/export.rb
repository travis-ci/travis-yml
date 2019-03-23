# frozen_string_literal: true
require 'validate/msgs'
require 'validate/review'

class Export < Struct.new(:opts)
  include Msgs

  SKIP = %w(
    empty_config
    invalid_format
    parse_error
  )

  def run
    codes.each do |code|
      print '.'
      write(code, msgs(code))
    end
    puts
  end

  private

    def codes
      codes = opts[:codes] if opts[:codes].any?
      codes ||= Record::Message.distinct.pluck(:code).sort
      codes - SKIP
    end

    def msgs(code)
      msgs_for(code).map do |msg|
        [Review.new(msg).result, msg.request_id, send(code, msg)]
      end
    end

    def write(code, msgs)
      level  = Record::Message.where(code: code).limit(1).first.level
      counts = msgs.group_by { |msg| msg[2] }.map { |key, msgs| [key, msgs.size] }.to_h
      width  = counts.values.max.to_s.size
      msgs   = msgs.uniq { |msg| msg[2] }
      msgs   = msgs.sort_by { |msg| [SORT[msg[0] || :default], msg[2]].join }
      msgs   = msgs.map { |msg| format(code, counts[msg[2]], width, *msg) }
      File.write("var/msgs/#{level}-#{code}", msgs.join("\n"))
    end

    def msgs_for(code)
      Record::Message.where(code: code).order('request_id desc')
    end

    STATUS = {
      ok:      '✅',
      not_ok:  '❌',
      check:   '🤔',
      default: ' '
    }

    SORT = {
      not_ok: 1,
      check: 2,
      default: 3,
      ok: 4,
    }

    def format(code, count, width, result, id, str)
      status = STATUS[result] || STATUS[:default]
      "#{status} #{id.to_s.rjust(8)} #{count.to_s.ljust(width)} [#{code}] #{str.to_s.gsub("\n", '\n')}"
    end
end

