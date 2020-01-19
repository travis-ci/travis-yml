# frozen_string_literal: true

module Travis
  module Yml
    module Web
      class Static < Sinatra::Base
        TYPES = {
          css:  'text/css',
          html: 'text/html',
          ico:  'image/vnd.microsoft.icon'
        }

        attr_reader :env

        get '/favicon.ico' do
          exists? ? ok : not_found
        end

        get '/css/*' do
          exists? ? ok : not_found
        end

        def ok
          status 200
          content_type TYPES[ext.to_sym]
          read
        end

        def exists?
          File.file?(path)
        end

        def read
          File.read(path)
        end

        def ext
          File.extname(path).sub('.', '')
        end

        def path
          @path ||= "public#{request.path_info.gsub('..', '')}"
        end
      end
    end
  end
end
