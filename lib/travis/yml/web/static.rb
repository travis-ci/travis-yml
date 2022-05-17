# frozen_string_literal: true
require 'digest/sha1'

module Travis
  module Yml
    module Web
      class Static < Sinatra::Base
        TYPES = {
          css:  'text/css',
          html: 'text/html',
          js:   'text/javascript',
          ico:  'image/vnd.microsoft.icon'
        }

        attr_reader :dir, :content

        def initialize(app, dir, **kwargs)
          @dir = dir
          super(app, **kwargs)
        end

        get '*' do
          exists? ? ok : pass
        end

        def ok
          status 200
          cache_control :public
          etag digest(content)
          content_type TYPES[ext.to_sym]
          content
        end

        def exists?
          File.file?(file)
        end

        def content
          @content ||= File.read(file)
        end

        def ext
          File.extname(file).sub('.', '')
        end

        def file
          @file ||= "#{dir}#{path}"
        end

        def path
          path = request.path_info.gsub('..', '')
          path = '/home' if path == '/'
          path = "#{path}.html" if File.extname(path).empty?
          path
        end

        def digest(str)
          Digest::SHA1.hexdigest(str)
        end
      end
    end
  end
end
