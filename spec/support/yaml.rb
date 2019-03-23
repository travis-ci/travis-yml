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
        LessYAML.load(yaml) || {}
      end
    end
  end
end
