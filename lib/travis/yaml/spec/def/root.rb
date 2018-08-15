require 'travis/yaml/spec/def/branches'
require 'travis/yaml/spec/def/compilers'
require 'travis/yaml/spec/def/dist'
require 'travis/yaml/spec/def/env'
require 'travis/yaml/spec/def/git'
require 'travis/yaml/spec/def/job'
require 'travis/yaml/spec/def/language'
require 'travis/yaml/spec/def/matrix'
require 'travis/yaml/spec/def/notifications'
require 'travis/yaml/spec/def/os'
require 'travis/yaml/spec/def/stack'
require 'travis/yaml/spec/def/stages'
require 'travis/yaml/spec/def/sudo'
require 'travis/yaml/spec/type/map'

module Travis
  module Yaml
    module Spec
      module Def
        class Support < Type::Map
          def define
            Type::Lang.registry.each do |_, const|
              const.new(self)
            end
          end
        end

        class Conditions < Type::Fixed
          register :conditions
          def define
            default :v1
            value :v0
            value :v1
          end
        end

        class Root < Type::Map
          register :root

          def define
            self.include :job, :support

            map    :version,        to: :str, format: ::Version::REQUIRE
            map    :language,       required: true, alias: :lang
            matrix :os,             required: true, to: :oss
            map    :dist,           required: true
            map    :sudo,           required: true
            matrix :env
            matrix :compiler,       to: :compilers, on: %i(c cpp)
            map    :matrix,         alias: :jobs
            map    :stages
            map    :notifications
            map    :stack
            map    :conditions,     to: :conditions, default: :v1
            map    :filter_secrets, to: :bool
            map    :trace,          to: :bool

            includes[:job] = Job.new(self)
          end

          def spec
            super.merge(includes: includes.map { |key, obj| [key, obj.spec] }.to_h)
          end

          def includes
            @includes ||= {}
          end
        end
      end
    end
  end
end
