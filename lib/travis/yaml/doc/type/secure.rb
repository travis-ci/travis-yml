module Travis
  module Yaml
    module Doc
      class Secure < Struct.new(:value)
        def self.name
          'Secure'
        end

        def serialize
          { secure: value.values.first.to_s }
        end

        def to_s
          { secure: obfuscated }
        end
        alias inspect to_s

        def secure?
          true
        end

        def ==(other)
          serialize == (other.is_a?(Secure) ? other.serialize : other)
        end

        private

          def obfuscated
            '*' * value.values.first.to_s.size
          end
      end
    end
  end

end
