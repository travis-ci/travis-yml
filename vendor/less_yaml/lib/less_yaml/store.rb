require 'less_yaml/load'
require 'yaml/store'

module LessYAML

  class Store < YAML::Store

    # Override YAML::Store#initialize to accept additional option
    # +safe_yaml_opts+.
    def initialize(file_name, yaml_opts = {}, safe_yaml_opts = {})
      @safe_yaml_opts = safe_yaml_opts
      super(file_name, yaml_opts)
    end

    # Override YAML::Store#load to use LessYAML.load instead of
    # YAML.load (via #safe_yaml_load).
    #--
    # PStore#load is private, while YAML::Store#load is public.
    #++
    def load(content)
      table = safe_yaml_load(content)
      table == false ? {} : table
    end

    private

    if LessYAML::YAML_ENGINE == 'psych'
      def safe_yaml_load(content)
        LessYAML.load(content, nil, @safe_yaml_opts)
      end
    else
      def safe_yaml_load(content)
        LessYAML.load(content, @safe_yaml_opts)
      end
    end

  end

end
