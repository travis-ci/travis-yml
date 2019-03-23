# frozen_string_literal: true
module Travis::Yml::Web
  class Router
    def initialize(map = {})
      @map = map
    end

    def call(env)
      req = Rack::Request.new(env)
      env_path = req.path_info.chomp(?/)
      env_path = ?/ if env_path.empty?

      @map.each do |path, app|
        next if env_path.nil? || path.nil?
        return app.call(env) if env_path == path
      end

      [404, {}, []]
    end
  end
end
