require 'validate/config'
require 'validate/result'

class Summary < Struct.new(:opts)
  def run
    header
    return unless results.count > 0
    warnings
    details
  end

  private

    def header
      puts "Analyzed latest configs for #{results.total} repos."
      puts "Found #{results.count} requests to have messages."
    end

    def warnings
      puts "\nWarnings by type:\n\n"
      results.groups.each do |code, group|
        puts "Found #{group.size.to_s.rjust(results.width)} times: #{code}"
      end
    end

    def details
      opts[:details].each do |code|
        next unless results[code]
        groups = results[code].group_by { |msg| [msg.key, msg.code, msg.msg] }
        groups = groups.sort_by { |info, msgs| [10000 - msgs.size, info.join.downcase] }.to_h
        width  = groups.values.map(&:size).max.to_s.size
        puts "\nDetails #{code}:\n\n"
        groups.each do |info, msgs|
          # next if skip?(*info)
          key, code, msg = *info
          msg = trunc(msg.to_s, 80)
          ids = msgs.map(&:id)
          ids = "e.g. #{ids[0..5]}" if ids.size > 5
          puts "Warning found #{msgs.size.to_s.rjust(width)} times: [#{key}] #{msg} (#{ids})"
        end
      end
    end

    def skip?(key, code, msg)
      key.to_s.include?('matrix.') # TODO
    end

    def trunc(str, width)
      return str if str.size <= width
      str[0..width] + ' ...'
    end

    def results
      @results ||= Results.new(opts)
    end
end

