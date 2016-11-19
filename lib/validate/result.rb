require 'validate/local'

class Msg < Struct.new(:id, :level, :key, :code, :msg)
  def key
    super.to_sym if super
  end

  def code
    super.to_sym if super
  end
end

class Results < Struct.new(:opts)
  def [](code)
    groups[code]
  end

  def total
    Local::Request.count
  end

  def count
    Local::Msg.select(:request_id).distinct.count(:request_id)
  end

  def width
    @width ||= groups.values.map(&:size).max.to_s.size
  end

  def groups
    @groups ||= group
  end

  private

    def all
      @all ||= filter(read)
    end

    def group
      groups = all.group_by(&:code)
      groups = groups.sort_by { |code, results| results.size }.reverse.to_h
      groups
    end

    def filter(result)
      skip   = OK + OK_ISH
      result = result.reject { |result| result.level == :info }
      result = result.reject { |result| skip.include?(result.code) }
      result
    end

    def read
      puts 'Loading results ...'
      msgs.all.map { |msg| Msg.new(msg.request_id, *msg.msg) }
    end

    def msgs
      @msgs ||= begin
        msgs = Local::Msg
        msgs = msgs.where(request_id: ids) if ids.any?
        msgs
      end
    end

    def scope
    end

    def ids
      opts[:ids] || []
    end

    def opts
      super || {}
    end
end
