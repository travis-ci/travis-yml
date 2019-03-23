# frozen_string_literal: true
require 'validate/config'
require 'validate/local'
require 'validate/table'

class Report < Struct.new(:opts)
  IDS = {
    2016 => 29916156
  }

  class Counts < Struct.new(:total, :min_id)
    def result
      %i(total info warn error).map do |type|
        [type, send(type)]
      end
    end

    def total
      scope.pluck(:request_id).size
    end

    %i(info warn error).each do |level|
      define_method(level) do
        scope.where(level: level).pluck(:request_id).size
      end
    end

    def scope
      scope = Record::Message.distinct.select(:request_id)
      scope = scope.where('id > ?', min_id) if min_id
      scope
    end
  end


  LEVELS = %i(info warn error)

  SKIP = %w(parse_error empty_config)

  def run
    header
    percentages
    levels
    counts if opts[:counts]
  end

  private

    def header
      puts "Analyzed latest configs for #{total} repos.\n\n"
    end

    def percentages
      puts "Number of requests that have messages\n\n"
      stats = Counts.new(total).result
      stats = stats.map { |row| row << percent(row[1]) }
      table = Table.new(stats, %w(level count %))
      puts table.to_s
      puts
    end

    def levels
      puts "Messages per code\n\n"
      stats = LEVELS.map do |level|
        stats = codes(level).map do |code|
          count = msgs(code)
          [level, code, count] # , percent(count)
        end
        stats.sort_by { |stat| stat[2] }.reverse
      end
      table = Table.new(stats.flatten(1), %w(level code count))
      puts table.to_s
      puts
    end

    def counts
      puts "Warnings and errors per request\n\n"
      stats = Record::Message.where(level: [:warn, :error]).select(:request_id, 'count(*) as c').group(:request_id).order('c desc')
      stats = stats.map { |count| [count.c, count.request_id] }
      stats = stats.group_by(&:first)
      stats = stats.map { |count, ids| [ids.size, count, ids.map(&:last)[0..10].join(' ')] }
      table = Table.new(stats, %w(requests messages id))
      puts table.to_s
      puts
    end

    def total
      @total ||= Record::Request.where(checked: true).count
    end

    def percent(count)
      return 0 if total == 0
      value = count.to_f / total * 100
      value.round(3)
    end

    def msgs(code)
      Record::Message.where(code: code).distinct.count
    end

    def codes(level)
      codes = Record::Message.where(level: level).distinct.select(:code).pluck(:code).sort
      codes - SKIP
    end
end

