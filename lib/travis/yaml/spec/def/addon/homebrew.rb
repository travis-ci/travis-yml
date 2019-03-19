# frozen_string_literal: true
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Homebrew < Type::Map
            register :homebrew

            def define
              map :update,   to: :bool
              map :packages, to: :seq
              map :casks,    to: :seq
              map :taps,     to: :seq
              map :brewfile, to: :scalar
            end
          end
        end
      end
    end
  end
end
