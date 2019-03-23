# frozen_string_literal: true
require 'travis/yaml/spec/type/fixed'
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          def self.providers
            @providers ||= begin
              names  = self.constants.sort
              consts = names.map { |name| const_get(name) }
              keys   = consts.map(&:registry_key)
              keys - %i(provider deploy_conditions deploy_branches deploy_edge heroku_strategy)
            end
          end

          class Deploy < Type::Map
            register :deploy

            def define
              strict false
              prefix :provider, type: :str

              map :provider,      to: :provider, required: true
              map :on,            to: :deploy_conditions
              map :allow_failure, to: :bool
              map :skip_cleanup,  to: :bool
              map :edge,          to: [:deploy_edge, :bool], edge: true

              # so called option specific branch hashes are valid, but
              # deprecated according to travis-build. e.g.:
              #
              #     provider: lambda
              #     function_name:
              #       develop: foo
              #       production: bar

              type :deploy_branches
            end
          end

          class Provider < Type::Fixed
            register :provider

            def define
              value *Def::Deploy.providers
            end
          end

          class Conditions < Type::Map
            register :deploy_conditions

            def define
              prefix :branch, type: [:str, :seq]
              self.include :support

              map :branch,       to: [:seq, :map], alias: :branches
              map :repo,         to: :str
              map :condition,    to: :str # TODO should this be a seq?
              map :all_branches, to: :bool
              map :tags,         to: :bool
            end
          end

          class Branches < Type::Map
            register :deploy_branches

            def define
              strict false
              # branch specific option hashes to be removed in v1.1.0
              deprecated :branch_specific_option_hash
            end
          end

          class Edge < Type::Map
            register :deploy_edge

            def define
              map :source, to: :str
              map :branch, to: :str
            end
          end
        end
      end
    end
  end
end
