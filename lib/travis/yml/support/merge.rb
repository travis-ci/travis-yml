require 'obj'

module Travis
  module Yml
    module Support
      class Merge < Obj.new(:lft, :rgt, :merge_mode)
        def apply
          mode = lft.merge_mode if lft.respond_to?(:merge_mode)
          mode ||= self.merge_mode || :deep_merge_append
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
            elsif arrays?(lft[key], rgt[key]) && lft[key].respond_to?(:merge_mode) && mode = lft[key].merge_mode
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

        def deep_merge_prepend(lft, rgt)
          keys(lft, rgt).inject(lft) do |hash, key|
            hash[key] = if hashes?(lft[key], rgt[key])
              send(mode(lft[key]) || :deep_merge_prepend, lft[key], rgt[key])
            elsif arrays?(lft[key], rgt[key])
              send(mode(lft[key]) || :prepend, lft[key], rgt[key])
            elsif lft.key?(key)
              lft[key]
            else
              rgt[key]
            end
            hash
          end
        end

        def deep_merge_patch(lft, rgt)
          keys(lft, rgt).inject(lft) do |hash, key|
            hash[key] = if hashes?(lft[key], rgt[key])
              send(mode(lft[key]) || :deep_merge_patch, lft[key], rgt[key])
            elsif arrays?(lft[key], rgt[key])
              send(mode(lft[key]) || :patch, lft[key], rgt[key])
            elsif lft.key?(key)
              lft[key]
            else
              rgt[key]
            end
            hash
          end
        end

        def prepend(lft, rgt)
          lft.replace(rgt + lft)
        end

        def append(lft, rgt)
          lft.replace(lft + rgt)
        end

        def patch(lft, rgt)
          lft.each.with_index do |_, ix|
            rgt[ix] = if hashes?(rgt[ix], lft[ix])
              deep_merge_patch(lft[ix], rgt[ix])
            else
              lft[ix] || rgt[ix]
            end
          end
          rgt
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
