# frozen_string_literal: true
require 'travis/support/obj'

module Travis
  module Yaml
    module Doc
      module Spec
        class Value < Obj.new(:opts)
          include Helper::Memoize

          def ==(other)
            to_s == other.to_s
          end

          def value
            opts[:value].to_s
          end
          alias to_s value

          def known
            [value] + aliases
          end
          memoize :known

          def version?
            !!opts[:version]
          end

          def version
            opts[:version]
          end

          def deprecated?
            !!opts[:deprecated]
          end

          def deprecated
            opts[:deprecated]
          end

          def edge?
            !!opts[:edge]
          end

          def alias_for?(other)
            aliases.include?(other.to_s.downcase)
          end

          def aliases
            Array(opts[:alias]).map(&:to_s)
          end
          memoize :aliases

          def support
            Support.new(only: only, except: except)
          end
          memoize :support

          def only
            opts[:only] || {}
          end

          def except
            opts[:except] || {}
          end
        end
      end
    end
  end
end
