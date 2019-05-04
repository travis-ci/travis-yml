module Spec
  module Support
    module Yaml
      def self.included(const)
        const.extend Module.new {
          def yaml(yaml)
            let(:yaml) { yaml }
          end
        }
      end

      def parse(yaml)
        ::Yaml.load(yaml) || {}
      end
    end
  end
end
