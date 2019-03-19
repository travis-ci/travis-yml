# frozen_string_literal: true
class Config
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def msgs
    return result unless yaml
    Timeout.timeout(30) do
      result.concat(config.msgs)
    end
    result
  rescue => e
    puts "\nRequest: #{request.id}"
    puts e.message, e.backtrace
    puts request.config
    exit
  end

  def to_hash
    config.to_hash
  end

  private

    def config
      @config ||= Travis::Yaml.load(yaml)
    end

    def result
      @result ||= []
    end

    def id
      request.id
    end

    def yaml
      @yaml ||= begin
        config = request.config

        if config.nil? || config.empty?
          result << [:warn, :config, :empty_config]
          return
        end

        config = LessYAML.load(config)

        if config.nil? || config.empty?
          result << [:warn, :config, :empty_config]
          return
        end

        if config['.result'] == 'parse_error'
          result << [:error, :config, :parse_error]
          return
        end

        config.delete('.result')
        YAML.dump(config)
      end
    end
end
