# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        EXCEPT = {
          linux: {
            language: %i(objective-c)
          },
          windows: {
            language: %i(objective-c)
          },
          freebsd: {
            language: %i(objective-c)
          }
        }

        ALIAS = {
          linux:   %i(ubuntu),
          osx:     %i(mac macos macosx ios),
          freebsd: %i(bsd),
          windows: %i(win)
        }

        class Oss < Type::Seq
          register :oss

          def define
            title 'Operating systems'
            summary 'Build environment operating systems'
            see 'Build Environment Overview': 'https://docs.travis-ci.com/user/reference/overview/'

            normal
            types :os
            export
          end
        end

        class Os < Type::Str
          register :os

          def define
            downcase

            value   :linux,   alias: ALIAS[:linux],   except: EXCEPT[:linux]
            value   :osx,     alias: ALIAS[:osx]
            value   :windows, alias: ALIAS[:windows], except: EXCEPT[:windows]
            value   :freebsd, alias: ALIAS[:freebsd], except: EXCEPT[:freebsd]
            value   :'linux-ppc64le' #, deprecated: 'use os: linux, arch: ppc64le'

            export
          end
        end
      end
    end
  end
end
