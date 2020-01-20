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

        attr_reader :dir

        def initialize(app, dir)
          @dir = dir
          super(app)
        end

        get '*' do
          exists? ? ok : pass
        end

        def ok
          status 200
          content_type TYPES[ext.to_sym]
          read
        end

        def exists?
          File.file?(file)
        end

        def read
          File.read(file)
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
      end
    end
  end
end
