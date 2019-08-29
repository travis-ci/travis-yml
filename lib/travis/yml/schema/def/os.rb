# frozen_string_literal: true
require 'travis/yml/schema/type'

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
            language: %i(c cpp go node_js rust shell)
          }
        }

        ALIAS = {
          linux:   %i(ubuntu),
          osx:     %i(mac macos macosx ios),
          windows: %i(win)
        }

        class Oss < Type::Seq
          register :oss

          def define
            title 'Operating systems'
            summary 'Build environment operating systems'

            normal
            types :os
            export
          end
        end

        class Os < Type::Str
          register :os

          def define
            downcase

            default :linux,   except: EXCEPT[:linux]
            default :osx,     except: EXCEPT[:osx]
            default :freebsd,   except: EXCEPT[:freebsd]
            default :windows, only:   ONLY[:windows]

            value   :linux,   alias: ALIAS[:linux],   except: EXCEPT[:linux]
            value   :osx,     alias: ALIAS[:osx],     except: EXCEPT[:osx]
            value   :freebsd,     alias: ALIAS[:freebsd],     except: EXCEPT[:freebsd]
            value   :windows, alias: ALIAS[:windows], only:   ONLY[:windows]

            export
          end
        end
      end
    end
  end
end
