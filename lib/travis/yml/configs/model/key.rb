require 'base64'
require 'openssl'

module Travis
  module Yml
    module Configs
      class Key < Struct.new(:private_key)
        include Base64

        def decrypt(str)
          key.private_decrypt(decode64(str.to_s))
        end

        def encrypt(str)
          encode64(key.public_encrypt(str.to_s))
        end

        def key
          @key ||= OpenSSL::PKey::RSA.new(private_key) if private_key
        end
      end
    end
  end
end
