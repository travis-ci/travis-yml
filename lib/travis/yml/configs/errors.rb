require 'travis/yml/errors'

module Travis
  module Yml
    module Configs
      module Errors
        class Error < Error
          def type
            self.class.name.demodulize.underscore.to_sym
          end
        end

        class ApiError < Error
          attr_reader :status

          def initialize(message, status)
            @status = status
            super(message)
          end

          def internal?
            status == 500
          end
        end

        InvalidRef = Class.new(InputError)
        UnknownRepo = Class.new(InputError)
        SyntaxError = Class.new(InputError)
        NotFound = Class.new(ApiError)
        Unauthorized = Class.new(ApiError)
        ServerError = Class.new(ApiError)

        MSGS = {
          syntax_error: 'Syntax error, could not parse %s',
          not_found: '%s %s not found on %s (%s)',
          unauthorized: 'Unable to authenticate with %s for %s %s (%s)',
          server_error: 'Error retrieving %s from %s (%s)'
        }

        def api_error(*args)
          case args.last.status
          when 401, 403 then unauthorized(*args)
          when 404 then not_found(*args)
          when 500 then server_error(*args)
          else raise(args.last)
          end
        end

        def syntax_error
          raise SyntaxError.new(MSGS[:syntax_error] % to_s)
        end

        def invalid_ref(ref)
          raise InvalidRef.new(ref)
        end

        def unauthorized(service, type, ref, e)
          raise Unauthorized.new(MSGS[:unauthorized] % [service, type, ref, e.message], e.status)
        end

        def not_found(service, type, ref, e)
          raise NotFound.new(MSGS[:not_found] % [type.capitalize, ref, service, e.message], e.status)
        end

        def server_error(service, type, ref, e)
          raise ServerError.new(MSGS[:server_error] % [to_s, service, e.message], e.status)
        end
      end
    end
  end
end
