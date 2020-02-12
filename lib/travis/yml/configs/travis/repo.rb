require 'travis/yml/helper/obj'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/travis/client'

module Travis
  module Yml
    module Configs
      module Travis
        class Repo < Struct.new(:slug)
          include Errors

          def fetch
            resp = client.get("repo/#{slug.to_s.sub('/', '%2F')}?representation=internal")
            map(Oj.load(resp.body))
          rescue Error => e
            api_error('Travis CI', :repo, slug, e)
          end

          private

            def map(attrs)
              {
                slug: attrs['slug'],
                private: attrs['private'],
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

            def client
              Client.new
            end
        end
      end
    end
  end
end
