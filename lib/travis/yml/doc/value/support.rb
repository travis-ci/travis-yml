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
                msg(key, Array(supporting[key]) - value)
              end
            end

            def except
              support.fetch(:except, {}).each do |key, value|
                msg(key, Array(supporting[key]) & value)
              end
            end

            def includes?(key, value)
              value.include?(supporting[key].to_s)
            end

            def msg(key, values)
              values.each do |value|
                @msgs << { on_key: key, on_value: value.to_s }
              end
            end
        end
      end
    end
  end
end
