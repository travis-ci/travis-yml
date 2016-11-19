require 'validate/config'

class Check < Struct.new(:opts)
  def run
    clear_all unless ids.any?
    check
  end

  def check
    puts "Found #{scope.count} configs to check."
    ix = 0
    scope.all.each do |request|
      ix += 1
      print "\r\e[2K#{ix} " unless ids.any?
      puts request.config if ids.any?
      msgs = Config.new(request).check
      store(request, msgs) if msgs.any?
      p msgs if ids.any? && msgs.any?
    end
  end

  def store(request, msgs)
    msgs.each do |msg|
      Local::Msg.create(repository_id: request.repository_id, request_id: request.id, msg: msg)
    end
  end

  def clear_all
    # request.update_attributes(result: nil)
    # # puts "Found warnings to be resolved for request id=#{request.id}: #{request.result}"
    # request.update_attributes!(config: nil, result: nil)
    Local::Request.update_all(result: nil)
    Local::Msg.delete_all
  end

  def scope
    scope = Local::Request
    # scope = scope.where('config IS NOT NULL')
    scope = scope.where(id: ids) if ids.any?
    scope
  end

  def ids
    opts[:ids] || []
  end
end
