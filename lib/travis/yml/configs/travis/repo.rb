require 'travis/yml/helper/obj'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/travis/client'

module Travis
  module Yml
    module Configs
      module Travis
        class Repo < Struct.new(:slug)
          include Errors, Helper::Obj

          def authorize(user_token)
            unauthenticated(slug) unless user_token
            get(path, auth: { token: user_token })
          end

          def fetch
            get(path, auth: internal_auth, representation: :internal)
          end

          private

            def path
              "repo/#{slug.to_s.sub('/', '%2F')}"
            end

            def get(path, opts)
              resp = client(opts).get(path, only(opts, :representation))
              map(Oj.load(resp.body) || {})
            rescue Error => e
              api_error('Travis CI', :repo, slug, e)
            end

            def map(attrs)
              {
                slug: attrs['slug'],
                private: attrs['private'],
                permissions: attrs['permissions'],
                default_branch: attrs.dig('default_branch', 'name'),
                allow_config_imports: allow_config_imports?(attrs),
                private_key: attrs['private_key'],
                token: attrs['token']
              }
            end

            def allow_config_imports?(attrs)
              settings = attrs.dig('user_settings', 'settings') || []
              setting = settings.detect { |setting| setting['name'] == 'config_imports' }
              setting ? setting['value'] : false
            end

            def client(opts)
              Client.new(opts)
            end

            def internal_auth
              { internal: "#{config[:travis][:app]}:#{config[:travis][:token]}" }
            end

            def config
              Yml.config
            end
        end
      end
    end
  end
end
