require 'cgi'
require 'oj'
require 'travis/yml/helper/obj'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/travis/client'

module Travis
  module Yml
    module Configs
      module Travis
        class Repo < Struct.new(:vcs_id, :provider)
          include Errors, Helper::Obj

          def fetch
            get(path, representation: :internal)
          end

          def to_s
            vcs_id
          end

          private

            def path
              if url_encode(vcs_id.to_s).match(%r{[^/]+%2[fF][^/]+})
                "repo/#{provider}/#{url_encode(vcs_id)}"
              else
                "repo_vcs/#{provider}/#{url_encode(vcs_id)}"
              end
            end

            def get(path, opts)
              resp = client(opts).get(path, only(opts, :representation))
              map(Oj.load(resp.body) || {})
            rescue Error => e
              api_error('Travis CI', :repo, vcs_id, e)
            end

            def map(attrs)
              {
                id: attrs['id'],
                vcs_type: attrs['vcs_type'],
                vcs_id: attrs['vcs_id'],
                github_id: attrs['github_id'],
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
