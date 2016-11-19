require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Dist < Type::Fixed
          register :dist

          def define
            default :precise
            downcase

            value :precise
            value :trusty
            value :osx, alias: %i(mac macos ios)
          end

          # def prepare
          #   self.value = 'osx'    if osx?
          #   self.value = 'trusty' if docker?
          #   super
          # end
          #
          # private
          #
          #   def osx?
          #     language == 'objective_c' || os == 'osx'
          #   end
          #
          #   def docker?
          #     services.include?('docker')
          #   end
          #
          #   def services
          #     root[:services] || []
          #   end
          #
          #   def os
          #     root[:os].first
          #   end
          #
          #   def language
          #     root[:language]
          #   end
        end
      end
    end
  end
end
