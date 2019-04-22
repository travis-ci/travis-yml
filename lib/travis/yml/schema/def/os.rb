# frozen_string_literal: true
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        # TODO check with Hiro, see https://github.com/travis-ci/travis-ci/issues/2320
        # however, python is listed in the docs: https://docs.travis-ci.com/user/osx-ci-environment/#Runtimes
        # also, node_js now seems to be supported: https://github.com/travis-ci/travis-ci/issues/2311#issuecomment-205549262

        # going forward we should really  make it so that the :os dictates what
        # languages are supported, not the other way around

        EXCEPT = {
          linux: {
            language: %i(objective-c)
          },
          osx: {
            language: %i(php perl erlang groovy clojure scala haskell)
          }
        }

        ONLY = {
          windows: {
            language: %i(shell csharp powershell)
          }
        }

        class Oss < Dsl::Seq
          register :oss

          def define
            normal
            type Os
            export
          end
        end

        class Os < Dsl::Enum
          register :os

          def define
            downcase

            default :linux,   except: EXCEPT[:linux]
            default :osx,     except: EXCEPT[:osx]
            default :windows, only:   ONLY[:windows]

            value   :linux,   alias: %i(ubuntu),        except: EXCEPT[:linux]
            value   :osx,     alias: %i(mac macos ios), except: EXCEPT[:osx]
            value   :windows, alias: %i(win),           only:   ONLY[:windows]

            export
          end
        end
      end
    end
  end
end
