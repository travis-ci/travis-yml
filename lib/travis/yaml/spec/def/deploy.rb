require 'travis/yaml/spec/type/fixed'
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Deploy < Type::Map
            register :deploy

            def define
              strict false
              prefix :provider, type: :scalar

              map :provider,     to: :scalar, required: true
              map :on,           to: :deploy_conditions
              map :skip_cleanup, to: :scalar, cast: :bool
              map :edge,         to: :scalar, cast: :bool, edge: true
            end
          end

          class Conditions < Type::Map
            register :deploy_conditions

            # TODO these should be picked from :root so we don't have to duplicate them
            # map :jdk, :node, :perl, :php, :python, :ruby, :scala, :node, to: Type::Version
            # map :ruby, only: { language: %i(ruby) }, to: Version

            def define
              strict false
              prefix :branch

              map :branch,       to: :seq
              map :repo,         to: :scalar
              map :condition,    to: :scalar
              map :all_branches, to: :scalar, cast: :bool
              map :tags,         to: :scalar, cast: :bool
            end
          end

          class Branches < Type::Map
            register :deploy_branches

            def define
              strict false
              type :branch
            end
          end

          class Branch < Type::Scalar
            register :deploy_branch
          end
        end
      end
    end
  end
end
