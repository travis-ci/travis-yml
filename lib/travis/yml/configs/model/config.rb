module Travis
  module Yml
    module Configs
      module Model
        class Config < Struct.new(:config, :keys, :key)
          def reencrypt
            walk { |obj| secure?(obj) ? { secure: process(obj[:secure]) } : obj }
          end

          private

            def secure?(obj)
              obj.is_a?(Hash) && obj.key?(:secure)
            end

            def process(obj)
              key.encrypt(keys.inject(obj) { |obj, key| key.decrypt(obj) })
            rescue OpenSSL::OpenSSLError => e
              obj
            end

            def walk(obj = config, &block)
              case obj
              when Hash
                block.call(obj).map { |key, obj| [key, walk(obj, &block)] }.to_h
              when Array
                obj.map { |obj| walk(obj, &block) }
              else
                obj
              end
            end
        end
      end
    end
  end
end
