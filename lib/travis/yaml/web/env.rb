module Travis::Yaml::Web
  module Env
    extend self

    def env
      ENV['RACK_ENV'.freeze] || ENV['ENV'.freeze]
    end

    %w{development staging test production}.each do |e|
      define_method(:"#{e}?") { env == e }
    end
  end
end
