# frozen_string_literal: true
require 'travis/yaml/helper/common'
require 'travis/yaml/doc/value/support'

module Travis
  module Yaml
    module Helper
      module Support

        include Helper::Common

        def relevant?
          support.supported?
        end

        def support
          @support ||= Doc::Value::Support.new(node.supporting, only(spec.spec, :only, :except))
        end
      end
    end
  end
end
