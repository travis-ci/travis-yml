require 'travis/yaml/support/registry'

module Travis
  module Yaml
    module Doc
      module Conform
        class Conform < Struct.new(:node, :opts)
          include Registry
        end
      end
    end
  end
end
