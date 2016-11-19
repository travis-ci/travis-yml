module Travis
  module Yaml
    module Doc
      class Value < Struct.new(:opts)
        def ==(other)
          to_s == other.to_s
        end

        def value
          opts[:value].to_s
        end
        alias to_s value

        def alias_for?(other)
          aliases.include?(other.to_s)
        end

        def aliases
          @aliases ||= Array(opts[:alias]).map(&:to_s)
        end

        def support
          @support ||= Support.new(only: only, except: except)
        end

        def only
          opts[:only] || {}
        end

        def except
          opts[:except] || {}
        end

        def opts
          super || {}
        end
      end
    end
  end
end
