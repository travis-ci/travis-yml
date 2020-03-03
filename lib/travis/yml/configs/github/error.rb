module Travis
  module Yml
    module Configs
      module Github
        class Error < StandardError
          MSG = 'GitHub %s %s responded with %s (%s)'

          attr_reader :method, :path, :status, :body

          def initialize(method, path, status, body)
            @method, @path, @status, @message = method, path, status, body
            msg = MSG % [method.upcase, path, status, body]
            super(msg.sub(' ()', ''))
          end
        end
      end
    end
  end
end
