# frozen_string_literal: true
require 'travis/yaml/helper/memoize'
require 'travis/yaml/support/registry'
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    module Doc
      module Validate
        class Validator < Obj.new(:spec, :node, :opts)
          include Registry
        end
      end
    end
  end
end
