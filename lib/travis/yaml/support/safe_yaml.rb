require 'psych'
require 'safe_yaml'

module SafeYAML
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
