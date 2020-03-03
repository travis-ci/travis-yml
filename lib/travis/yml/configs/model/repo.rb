require 'travis/yml/configs/model/config'
require 'travis/yml/configs/model/key'

module Travis
  module Yml
    module Configs
      module Model
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

          def authorize(user_token)
            Travis::Repo.new(slug).authorize(user_token)
          end

          def reencrypt(config, keys)
            Model::Config.new(config, keys, key).reencrypt
          end

          def complete?
            %i(private token private_key allow_config_imports).all? do |key|
              attrs.key?(key) && !attrs[key].nil?
            end
          end

          def ==(other)
            slug == other.slug
          end
        end
      end
    end
  end
end
