require 'travis/yml/configs/model/config'
require 'travis/yml/configs/model/key'

module Travis
  module Yml
    module Configs
      module Model
        class Repo < Struct.new(:attrs)
          def id
            attrs[:id]
          end

          def owner_name
            @owner_name ||= slug.split('/').first
          end

          def github_id
            attrs[:github_id]
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

          REQUIRED = %i(id github_id private private_key allow_config_imports)

          def complete?
            return false unless REQUIRED.all? { |key| given?(key) }
            public? || given?(:token)
          end

          def given?(key)
            attrs.key?(key) && !attrs[key].nil?
          end

          def ==(other)
            slug == other.slug
          end
        end
      end
    end
  end
end
