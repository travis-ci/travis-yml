require 'base64'
require 'travis/yml/configs/github/client'

module Travis
  module Yml
    module Configs
      module Github
        class Content < Struct.new(:repo, :path, :ref)
          include Base64, Errors

          def content
            @content ||= normalize(fetch)
          end

          private

            def fetch
              path = "repositories/#{repo.github_id}/contents/#{self.path}"
              resp = client.get(path, ref: ref)
              data = Oj.load(resp.body)
              decode64(data['content'])
            rescue Github::Error => e
              api_error('GitHub', :file, [repo.slug, path].join(':'), e)
            rescue TypeError => e
              nil
            end

            NBSP = "\xC2\xA0".force_encoding('binary')

            def normalize(str)
              str = normalize_nbsp(str)
              str = remove_utf8_bom(str)
              str
            end

            def normalize_nbsp(str)
              str.gsub(/^(#{NBSP})+/) { |match| match.gsub(NBSP, ' ') }
            end

            def remove_utf8_bom(str)
              str.force_encoding('UTF-8').sub /^\xEF\xBB\xBF/, ''
            end

            def client
              Client.new(repo.token)
            end
        end
      end
    end
  end
end
