require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        # TODO check with Hiro
        # see https://github.com/travis-ci/travis-ci/issues/2320
        UNSUPPORTED = {
          linux: %i(objective_c),
          osx:   %i(node_js python php perl erlang groovy clojure scala haskell)
        }

        class Oss < Type::Seq
          register :oss

          def define
            type Os
            default :linux, except: { language: UNSUPPORTED[:linux] }
            default :osx,   except: { language: UNSUPPORTED[:osx] }
          end
        end

        class Os < Type::Fixed
          register :os

          def define
            downcase

            value :linux, alias: %i(ubuntu),        except: { language: UNSUPPORTED[:linux] }
            value :osx,   alias: %i(mac macos ios), except: { language: UNSUPPORTED[:osx] }
          end
        end
      end
    end
  end
end
