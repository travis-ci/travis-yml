require 'travis/yaml/helper/common'
require 'travis/yaml/support/registry'

module Travis
  module Yaml
    module Doc
      module Normalize
        class Normalizer < Struct.new(:parent, :spec, :key, :value)
          include Helper::Common, Registry
        end
      end
    end
  end
end
