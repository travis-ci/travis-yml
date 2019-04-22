# frozen_string_literal: true

module Travis
  module Yml
    module Doc
      module Value
        class Support < Obj.new(:support, :supporting, :obj)
          def supported?
            eval unless @msgs
            msgs.empty?
          end
          alias relevant? supported?

          def msgs
            eval unless @msgs
            @msgs
          end

          private

            def eval
              @msgs = []
              return unless obj
              only
              except
            end

            def only
              support.fetch(:only, {}).each do |key, value|
                next if supporting(key) & value == value # multios
                msg(key, supporting(key) - value)
              end
            end

            def except
              support.fetch(:except, {}).each do |key, value|
                next if supporting(key).-(value).any? # multios
                msg(key, supporting(key) & value)
              end
            end

            def msg(key, values)
              values.each do |value|
                @msgs << { on_key: key, on_value: value.to_s }
              end
            end

            def supporting(key)
              Array(super()[key])
            end
        end
      end
    end
  end
end
