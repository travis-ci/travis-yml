require 'cgi'
require 'oj'
require 'travis/yml/helper/obj'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/travis/client'

module Travis
  module Yml
    module Configs
      module Travis
        class Repo < Struct.new(:slug, :provider)
          include Errors, Helper::Obj

          def fetch
            get(path, representation: :internal)
          end

          def to_s
            slug
          end

          private

            def path
              "repo/#{provider}/#{url_encode(slug)}"
            end

            def get(path, opts)
              resp = client(opts).get(path, only(opts, :representation))
              map(Oj.load(resp.body) || {})
            rescue Error => e
              api_error('Travis CI', :repo, slug, e)
            end

            def map(attrs)
              {
                id: attrs['id'],
                vcs_type: attrs['vcs_type'],
                github_id: attrs['github_id'],
                slug: attrs['slug'],
                private: attrs['private'],
                vcs_type: attrs['vcs_type'],
                permissions: attrs['permissions'],
                default_branch: attrs.dig('default_branch', 'name'),
                allow_config_imports: allow_config_imports?(attrs),
                private_key: attrs['private_key'],
                token: attrs['token']
              }
            end

            def allow_config_imports?(attrs)
              settings = attrs.dig('user_settings', 'settings') || []
              setting = settings.detect { |setting| setting['name'] == 'allow_config_imports' }
              setting ? setting['value'] : false
            end

            def url_encode(str)
              CGI.escape(str)
            end

            def client(opts)
              Client.new(opts)
            end

            def config
              Yml.config
            end
        end
      end
    end
  end
end
