class Config < Struct.new(:request)
  def check
    return result unless yaml = normalize(request.config)
    config = Travis::Yaml.load(yaml)
    result.concat(config.msgs)
    filter(result)
  # rescue => e
  #   result << [:travis_yaml_error, e.message] if e.message.include?('Travis::Yaml::Parser::Psych')
  #   result
  rescue => e
    puts e.message, e.backtrace
    puts request.config
    exit
  end

  private

    def filter(result)
      skip   = OK + OK_ISH
      result = result.reject { |level, key, *| level == :info }
      result = result.reject { |level, key, *| key && skip.include?(key) }
      result
    end

    def result
      @result ||= []
    end

    def id
      request.id
    end

    def normalize(config)
      if config.nil? || config.empty?
        result << [:warn, :config, :empty_config]
        return
      end

      config = YAML.load(config)

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
