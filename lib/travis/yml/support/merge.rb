require 'obj'

module Travis
  module Yml
    module Support
      class Merge < Obj.new(:lft, :rgt, :merge_mode)
        def apply
          mode = lft.merge_mode if lft.respond_to?(:merge_mode)
          mode ||= self.merge_mode || :merge
          send(mode, lft, rgt)
        end

        def replace(lft, _)
          lft
        end

        def merge(lft, rgt)
          keys(lft, rgt).inject(lft) do |hash, key|
            hash[key] = lft.key?(key) ? lft[key] : rgt[key]
            hash
          end
        end

        def deep_merge(lft, rgt)
          keys(lft, rgt).inject(lft) do |hash, key|
            hash[key] = if hashes?(lft[key], rgt[key])
              send(mode(lft[key]) || :deep_merge, lft[key], rgt[key])
            elsif arrays?(lft[key], rgt[key]) && mode = lft[key].merge_mode
              send(mode, lft[key], rgt[key])
            elsif lft.key?(key)
              lft[key]
            else
              rgt[key]
            end
            hash
          end
        end

        def deep_merge_append(lft, rgt)
          keys(lft, rgt).inject(lft) do |hash, key|
            hash[key] = if hashes?(lft[key], rgt[key])
              send(mode(lft[key]) || :deep_merge_append, lft[key], rgt[key])
            elsif arrays?(lft[key], rgt[key])
              send(mode(lft[key]) || :append, lft[key], rgt[key])
            elsif lft.key?(key)
              lft[key]
            else
              rgt[key]
            end
            hash
          end
        end

        def prepend(lft, rgt)
          lft.replace(lft + rgt)
        end

        def append(lft, rgt)
          lft.replace(rgt + lft)
        end

        def mode(obj)
          obj.merge_mode if obj.respond_to?(:merge_mode)
        end

        def hashes?(*objs)
          objs.all? { |obj| obj.is_a?(Hash) }
        end

        def arrays?(*objs)
          objs.all? { |obj| obj.is_a?(Array) }
        end

        def keys(lft, rgt)
          keys = lft.keys + rgt.keys
          keys.uniq
        end
      end
    end
  end
end
