# frozen_string_literal: true
module Travis::Yml::Web
  class Router
    def initialize(map = {})
      @map = map
    end

    def call(env)
      req = Rack::Request.new(env)
      path = req.path_info.chomp(?/)
      path = ?/ if path.empty?

      @map.each do |pattern, const|
        next if path.nil? || pattern.nil?
        return const.new.call(env) if match?(pattern, path)
      end

      [404, {}, []]
    end

    def match?(pattern, path)
      return pattern == path unless pattern.include?('/*')
      path.start_with?(pattern.sub('/*', ''))
    end
  end
end
