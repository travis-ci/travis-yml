require 'travis/yml/configs/imports'

module Travis
  module Yml
    module Configs
      class Ctx < Struct.new(:data, :opts)
        def imports
          @imports ||= Imports.new(self)
        end

        def repos
          @repos ||= Model::Repos.new
        end

        def data
          super || {}
        end
      end
    end
  end
end
