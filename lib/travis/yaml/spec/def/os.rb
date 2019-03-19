# frozen_string_literal: true
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        # TODO check with Hiro, see https://github.com/travis-ci/travis-ci/issues/2320
        # however, python is listed in the docs: https://docs.travis-ci.com/user/osx-ci-environment/#Runtimes
        # also, node_js now seems to be supported: https://github.com/travis-ci/travis-ci/issues/2311#issuecomment-205549262
        UNSUPPORTED = {
          linux: %i(objective-c),
          # TODO list supported languages instead?
          osx:   %i(php perl erlang groovy clojure scala haskell)
        }
        SUPPORTED = {
          windows: %i(
            bash
            csharp
            powershell
            script
            sh
            shell
          )
        }

        class Oss < Type::Seq
          register :oss

          def define
            type Os
            default :linux, except: { language: UNSUPPORTED[:linux] }
            default :osx,   except: { language: UNSUPPORTED[:osx] }
            default :windows, only: { language: SUPPORTED[:windows] }
          end
        end

        class Os < Type::Fixed
          register :os

          def define
            downcase

            default :linux, except: { language: UNSUPPORTED[:linux] }
            default :osx,   except: { language: UNSUPPORTED[:osx] }
            default :windows, only: { language: SUPPORTED[:windows] }
            value   :linux, alias: %i(ubuntu),        except: { language: UNSUPPORTED[:linux] }
            value   :osx,   alias: %i(mac macos ios), except: { language: UNSUPPORTED[:osx] }
            value   :windows, alias: %i(win),           only: { language: SUPPORTED[:windows] }
          end
        end
      end
    end
  end
end
