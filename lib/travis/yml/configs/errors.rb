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

          def initialize(msg, status, data)
            @status = status
            data[:service] = data[:service] == 'Travis CI' ? :travis_ci : :github
            super(msg, data)
          end

          def internal?
            status == 500
          end
        end

        InvalidRef   = Class.new(InputError)
        Unauthorized = Class.new(ApiError)
        RepoNotFound = Class.new(ApiError)
        FileNotFound = Class.new(ApiError)
        ServerError  = Class.new(ApiError)

        MSGS = {
          repo_not_found: 'Repo %s not found on %s (%s)',
          file_not_found: 'File %s not found on %s (%s)',
          unauthorized:   'Unable to authenticate with %s for %s %s (%s)',
          server_error:   'Error retrieving %s from %s (%s)'
        }

        def api_error(*args)
          case args.last.status
          when 401, 403 then unauthorized(*args)
          when 404 then not_found(*args)
          when 500 then server_error(*args)
          else raise(args.last)
          end
        end

        def invalid_ref(ref)
          raise InvalidRef.new(ref)
        end

        def unauthorized(service, type, ref, e)
          msg = MSGS[:unauthorized] % [service, type, ref, e.message]
          raise Unauthorized.new(msg, e.status, service: service, ref: ref)
        end

        def not_found(service, type, ref, e)
          msg = MSGS[:"#{type}_not_found"] % [ref, service, e.message]
          const = self.class.const_get("#{type.capitalize}NotFound")
          raise const.new(msg, e.status, service: service, ref: ref)
        end

        def server_error(service, type, ref, e)
          msg = MSGS[:server_error] % [to_s, service, e.message]
          raise ServerError.new(msg, e.status, service: service, ref: ref)
        end
      end
    end
  end
end
