require 'travis/yml/configs/model/config'
require 'travis/yml/configs/model/key'

module Travis
  module Yml
    module Configs
      class Repo < Struct.new(:attrs)
        def owner_name
          @owner_name ||= slug.split('/').first
        end

        def slug
          attrs[:slug]
        end

        def token
          attrs[:token]
        end

        def private?
          attrs[:private]
        end

        def public?
          !private?
        end

        def default_branch
          attrs[:default_branch] || 'master'
        end

        def allow_config_imports?
          attrs[:allow_config_imports]
        end

        def key
          @key ||= Key.new(attrs[:private_key])
        end

        def reencrypt(config, keys)
          Model::Config.new(config, keys, key).reencrypt
        end

        # def decrypt(config, key)
        # end
        #
        # def encrypt(config)
        #   Model::Config.new(config, self.key).encrypt
        # end

        def ==(other)
          slug == other.slug
        end
      end
    end
  end
end
