module Spec
  module Support
    module Matchers
      class HaveNormalForms
        # anyOf nodes need to have at least one normal form

        attr_reader :schema

        def description
          ''
        end

        def matches?(schema)
          @schema = catch :missing_normal do
            walk(schema[:definitions])
            walk(schema[:allOf])
          end
          @schema.nil?
        end

        def failure_message
          "not normal: #{schema.inspect}"
        end

        def failure_message_when_negated
          ''
        end

        def walk(obj)
          if obj.nil?
            # skip
          elsif obj.is_a?(::Array)
            obj.each { |obj| walk(obj) } && nil
          elsif obj[:anyOf]
            check(obj)
            walk(obj[:anyOf])
          elsif obj[:allOf]
            walk(obj[:allOf])
          elsif obj[:oneOf]
            walk(obj[:oneOf])
          elsif obj[:type] == :array
            walk(obj[:items])
          elsif obj[:type] == :object
            walk(obj[:properties])
          elsif obj[:'$ref']
            # skip
          elsif obj[:'$id']
            # skip?
          elsif %i(boolean number string).include?(obj[:type])
          elsif obj.is_a?(::Hash)
            obj.each { |_, obj| walk(obj) } && nil
          else
            raise "unhandled node #{obj.class}"
          end
        end

        def expand(obj)
          obj.is_a?(::Array) ? obj.map { |obj| expand(obj) } : obj
        end

        SKIP = [
          [type: :string]
        ]

        def check(obj)
          return if SKIP.include?(obj[:anyOf])
          return if obj[:anyOf].all? { |obj| obj.is_a?(::Hash) && obj.key?(:'$ref') && obj.size == 1 }
          normal = expand(obj[:anyOf]).flatten.select { |obj| obj[:normal] }
          throw(:missing_normal, obj) if normal.size == 0
        end
      end

      def have_normal_forms
        HaveNormalForms.new
      end
    end
  end
end

describe Travis::Yml, 'schema' do
  subject { described_class.schema }

  # xit { should have_normal_forms }
end
