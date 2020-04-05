require 'obj'

module Travis
  module Yml
    module Support
      class Merge < Obj.new(:lft, :rgt)
        MERGE_MODES = %i(
          replace
          merge
          deep_merge
          deep_merge_append
          deep_merge_prepend
          append
          prepend
        )

        def apply
          send(mode(lft, rgt) || :deep_merge_append, lft, rgt)
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
              send(mode(lft[key], rgt[:key]) || :deep_merge, lft[key], rgt[key])
            elsif arrays?(lft[key], rgt[key]) && lft[key].respond_to?(:merge_modes) && mode = lft[key].merge_modes[:rgt] # ??
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
              send(mode(lft[key], rgt[:key]) || :deep_merge_append, lft[key], rgt[key])
            elsif arrays?(lft[key], rgt[key])
              send(mode(lft[key], rgt[:key]) || :append, lft[key], rgt[key])
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
              send(mode(lft[key], rgt[:key]) || :deep_merge_prepend, lft[key], rgt[key])
            elsif arrays?(lft[key], rgt[key])
              send(mode(lft[key], rgt[:key]) || :prepend, lft[key], rgt[key])
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

        def mode(lft, rgt)
          mode = lft.merge_modes[:rgt] if lft.respond_to?(:merge_modes)
          mode ||= rgt.merge_modes[:lft] if rgt.respond_to?(:merge_modes)
          mode = normalize(mode)
          unknown_merge_mode!(mode) if mode && !MERGE_MODES.include?(mode)
          mode
        end

        def normalize(mode)
          mode = Array(mode).flatten.first
          mode = mode.to_s.gsub('-', '_') if mode
          mode&.to_sym
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

        def unknown_merge_mode!(mode)
          raise ArgumentError.new("Unknown merge mode #{mode}")
        end
      end
    end
  end
end
