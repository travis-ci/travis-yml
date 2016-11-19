require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class UnknownKeys < Conform
          register :unknown_keys

          def apply?
            node.strict?
          end

          def apply
            node.children.delete_if do |child|
              next false if child.known?
              node.msg :error, :unknown_key, child.key, child.value
            end
          end
        end
      end
    end
  end
end
