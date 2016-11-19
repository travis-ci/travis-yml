require 'travis/yaml/doc/conform/conform'

module Travis
  module Yaml
    module Doc
      module Conform
        class Template < Conform
          register :template

          def apply?
            unknown.any?
          end

          def apply
            unknown.each do |var|
              node.parent.parent.msg :error, :unknown_var, var
              node.value = nil
            end
          end

          private

            def unknown
              @unknown ||= vars.select { |var| unknown?(var) }
            end

            def unknown?(var)
              !known.include?(var)
            end

            def known
              opts[:vars]
            end

            def vars
              node.value.to_s.scan(/%{([^}]+)}/).to_a.flatten
            end
        end
      end
    end
  end
end
