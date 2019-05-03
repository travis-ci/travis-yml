module Travis
  module Yml
    module Parts
      # With the following config sources, sent/included in this order:
      #
      #   # from api payload
      #   script: ./api
      #   env:
      #     global:
      #       api: true
      #       foo: 1
      #
      #   # from .travis.yml, merge_mode: deep_merge
      #   script: ./travis_yml
      #   env:
      #     global:
      #       travis_yml: true
      #       foo: 2
      #
      #   # from imported.yml, merge_mode: deep_merge
      #   script: ./imported
      #   env:
      #     global:
      #       imported: true
      #       foo: 3
      #
      #
      # We expect the result:
      #
      #   script: ./api
      #   env:
      #     global:
      #       imported: true
      #       foo: 1
      #       travis_yml: true
      #       api: true
      #
      # This is because:
      #
      # * The order of the list represents the order of precedence, what's
      #   listed first wins.
      # * "Winning" in terms of ENV vars means being listed later, and/or
      #   having the right value.
      # * The strange position of the key :foo is due to Ruby's behaviour of
      #   keeping the key in the same place, but overwriting the value.

      class Merge < Struct.new(:parts)
        def apply
          parts.inject do |lft, rgt|
            send(merge_mode(rgt), rgt.to_h, lft.to_h)
          end
        end

        private

          def merge_mode(part)
            part.respond_to?(:merge_mode) ? part.merge_mode : :merge
          end

          def replace(lft, rgt)
            rgt
          end

          # We cannot use Ruby's Hash#merge because it keeps the left hand side
          # key object. We need to have the right hand side key win if it is
          # present on both sides, so we retain the correct src and line.
          def merge(lft, rgt)
            keys(lft, rgt).inject({}) do |hash, key|
              hash[key] = rgt.key?(key) ? rgt[key] : lft[key]
              hash
            end
          end

          def deep_merge(lft, rgt)
            keys(lft, rgt).inject({}) do |hash, key|
              hash[key] = if lft[key].is_a?(Hash) && rgt[key].is_a?(Hash)
                deep_merge(lft[key], rgt[key])
              elsif rgt.key?(key)
                rgt[key]
              else
                lft[key]
              end
              hash
            end
          end

          # Keep the order of keys, but use the key from the right hand side if
          # present on both sides.
          def keys(lft, rgt)
            lft, rgt = lft.keys, rgt.keys
            lft = lft.map { |key| (ix = rgt.index(key)) ? rgt[ix] : key }
            lft.concat(rgt).uniq
          end
      end
    end
  end
end
