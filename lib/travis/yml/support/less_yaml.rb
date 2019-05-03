# frozen_string_literal: true
$: << File.expand_path('../../../../../vendor/less_yaml/lib', __FILE__)

require 'psych'
require 'less_yaml/load'

class Object
  attr_accessor :line, :anchors
end

class Key < String
  %i(downcase gsub sub tr to_s).each do |name|
    define_method(name) do |*args, &block|
      obj = Key.new(super(*args, &block))
      obj.line = line
      obj
    end
  end
end

module LessYAML
  OPTIONS[:default_mode] = :safe

  singleton_class.prepend Module.new {
    def load(*args)
      line(super)
    end

    # Ruby freezes strings that are used as hash keys, so we cannot just set
    # the line on the string, but have to pass back an array at parse time,
    # unwrap it here, and use a custom class Key in downstream code.
    #
    # https://gist.github.com/svenfuchs/57b2a7909db1565201a27c4519e07635
    def line(obj, key = false)
      if obj.is_a?(Hash)
        obj.map { |key, obj| [line(key, true), line(obj)] }.to_h
      elsif obj.is_a?(Array) && obj.first != :__line__
        obj.map { |obj| line(obj) }
      elsif obj.is_a?(Array)
        _, obj, line, quoted = *obj
        obj = key ? Key.new(obj.to_s) : quoted ? obj : cast(obj)
        obj.line = line unless obj.frozen?
        obj
      else
        obj
      end
    end

    INT = /\A[\d]+\Z/

    def cast(obj)
      case obj.downcase
      when INT     then obj.to_i
      when 'true'  then true
      when 'false' then false
      when 'null'  then nil
      else obj
      end
    end
  }

  class PsychHandler
    prepend Module.new {
      attr_accessor :last_scalar, :anchor_keys

      def anchor_keys
        @anchor_keys ||= []
      end

      def event_location(start_line, *)
        @line = start_line
      end

      def scalar(value, anchor, tag, plain, quoted, style)
        anchor_keys << last_scalar if anchor
        self.last_scalar = value
        value = [:__line__, value, @line, quoted] unless tag || value == '<<'
        super
      end

      def start_mapping(anchor, tag, implicit, style)
        anchor_keys << last_scalar if anchor
        super
      end

      def start_sequence(anchor, tag, implicit, style)
        anchor_keys << last_scalar if anchor
        super
      end

      def end_current_structure
        super
        @current_structure.anchors = anchor_keys if @current_structure
      end

      def end_document(implicit)
        anchors = @result.anchors || []
        @result = @result.merge(__anchors__: anchors) if @result.is_a?(Hash) && !anchors.empty?
        @block.call(@result)
        super
      end
    }
  end

  class Transform
    ToFloat.class_eval do
      prepend Module.new {
        def transform?(value)
          [false, value]
        end
      }
    end

    ToBoolean::PREDEFINED_VALUES.replace(
      'true'  => true,
      'false' => false
    )
  end
end
