# frozen_string_literal: true
require 'travis/yaml/helper/common'
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    module Doc
      module Value
        class Support < Obj.new(:values, :spec)
          include Helper::Common

          attr_reader :msgs

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
              only.keys.each do |key|
                given  = to_array(values[key])
                values = to_array(only[key]).map(&:to_s)
                next unless given == given.-(values)
                given.each { |value| msg(key, value) }
              end
            end

            def excluded
              except.keys.each do |key|
                given  = to_array(values[key])
                values = to_array(except[key]).map(&:to_s)
                next unless given == given.&(values)
                given.each { |value| msg(key, value) }
              end
            end

            def msg(key, value)
              @msgs << { on_key: key, on_value: value }
            end

            def only
              spec[:only] || {}
            end

            def except
              spec[:except] || {}
            end
        end
      end
    end
  end
end
