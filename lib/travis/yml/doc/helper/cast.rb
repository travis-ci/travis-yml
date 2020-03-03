# frozen_string_literal: true
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      class Cast < Obj.new(:value, :type)
        TRUES   = ['true', 'on', 'yes', 'enabled', 'required']
        FALSES  = ['false', 'off', 'no', 'disabled', 'not required']
        BOOLS   = TRUES + FALSES

        TRUE    = /^(#{TRUES.join('|')})$/
        FALSE   = /^(#{FALSES.join('|')})$/
        BOOLEAN = /^(#{BOOLS.join('|')})$/

        def apply
          send(:"to_#{type}", value)
        end

        def msgs
          @msgs ||= []
        end

        private

          def to_str(value)
            case value
            when Symbol     then value.to_s
            when Numeric    then value.to_s
            when TrueClass  then value.to_s
            when FalseClass then value.to_s
            else value
            end
          end

          def to_enum(value)
            to_str(value)
          end

          def to_num(value)
            return value unless str?(value) && num?(value)
            value.include?('.') ? value.to_f : value.to_i
          end

          def to_bool(value)
            case value
            when Numeric then value
            when FALSE   then false
            when TRUE    then true
            when String  then str_to_bool(value)
            else !!value
            end
          end

          def str_to_bool(value)
            other = clean(value)
            return other unless other.nil?
            other = match(value)
            return other unless other.nil?
            value
          end

          def clean(value)
            value = value.gsub(/\W/, '')
            return if value == self.value || BOOLEAN !~ value
            value = to_bool(value)
            msgs << [:clean_value, original: self.value, value: value]
            value
          end

          def match(value)
            matched = Match.new(BOOLS, value).run
            return if matched.nil?
            value = to_bool(matched)
            msgs << [:find_value, original: self.value, value: value]
            value
          end
      end
    end
  end
end
