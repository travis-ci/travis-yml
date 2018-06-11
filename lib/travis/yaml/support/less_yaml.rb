$: << File.expand_path('../../../../../vendor/less_yaml/lib', __FILE__)

require 'psych'
require 'less_yaml/load'

module LessYAML
  OPTIONS[:default_mode] = :safe

  # TODO talk to Dan Tao about a public api for this

  class Transform
    ToFloat.class_eval do
      # if any of this raises our monkeypatch is probably outdated.
      raise unless instance_method(:transform?)

      prepend Module.new {
        def transform?(value)
          [false, value]
        end
      }
    end

    ToInteger.class_eval do
      raise unless instance_method(:transform?)

      def transform?(value)
        [false, value]
      end
    end

    ToBoolean::PREDEFINED_VALUES.replace(
      'true'  => true,
      'false' => false
    )
  end
end
