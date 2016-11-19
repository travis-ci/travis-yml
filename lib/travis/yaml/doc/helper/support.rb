require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      class Support < Struct.new(:node, :opts)
        include Helper::Common

        attr_reader :msgs

        def initialize(*)
          super
        end

        def supported?
          return msgs.empty? if msgs
          @msgs = []
          required
          excluded
          msgs.empty?
        end
        alias relevant? supported?

        private

          def required
            key = only.keys.detect do |key|
              given  = to_a(node.root[key])
              values = to_a(only[key]).map(&:to_s)
              given.empty? || given.-(values).any?
            end
            msg(key) if key
          end

          def excluded
            key = except.keys.detect do |key|
              given  = to_a(node.root[key])
              values = to_a(except[key]).map(&:to_s)
              given.any? && given.&(values).any?
            end
            msg(key) if key
          end

          def msg(key)
            value = node.root[key]
            value = value.first if value.is_a?(Array)
            @msgs << [key, value]
          end

          def only
            opts[:only] || {}
          end

          def except
            opts[:except] || {}
          end

          def support
            super || Support.new
          end
      end
    end
  end
end
