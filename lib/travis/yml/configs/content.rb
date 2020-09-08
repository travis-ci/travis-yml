require 'base64'
require 'travis/yml/remote_vcs/repository'

module Travis
  module Yml
    module Configs
      class Content < Struct.new(:repo, :path, :ref)
        include Base64, Errors

        def content
          puts "test 2"
          @content ||= normalize(fetch)
        end

        private

        def fetch
          data = client.content(id: repo.id, path: path, ref: ref)
          decode64(data['content'].to_s)
        rescue Faraday::ClientError => e
          api_error('RemoteVcs', :file, [repo.slug, self.path].join(':'), OpenStruct.new(e.response))
        rescue TypeError => e
          nil
        end

        NBSP = "\xC2\xA0".force_encoding('binary')

        def normalize(str)
          return unless str
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
          @clien ||= ::Travis::Yml::RemoteVcs::Repository.new
        end
      end
    end
  end
end
