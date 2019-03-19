# frozen_string_literal: true
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Apt < Type::Map
            register :apt

            def define
              prefix :packages
              map :packages, to: :seq
              map :sources,  to: :apt_sources
              map :dist,     to: :scalar
            end
          end

          class AptSources < Type::Seq
            register :apt_sources

            def define
              type :scalar, :map, strict: false
            end
          end
        end
      end
    end
  end
end
