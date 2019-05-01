# frozen_string_literal: true

module Travis
  module Yml
    class Matrix < Obj.new(:config)
      def rows
        rows = expand
        rows = with_included(rows)
        rows = with_default(rows)
        rows = without_excluded(rows)
        rows = with_env_arrays(rows)
        rows = with_global_env(rows)
        rows = with_shared(rows)
        rows = with_os(rows)
        rows = with_arch(rows)
        rows = cleaned(rows)
        rows = uniq(rows)
        rows
      end

      def axes
        keys
      end

      private

        def expand
          rows = Array(values.inject { |lft, rgt| lft.product(rgt) } || [])
          rows = rows.map { |row| keys.zip(Array(row).flatten).to_h }
          rows
        end

        def with_included(rows)
          # If there's one row at this point, and it has single-entry
          # expand values, and we also have matrix includes, remove the row
          # because it's probably an unnecessary duplicate.
          # TODO: verify this
          if rows.size == 1 && only(rows.first, *expand_keys).all? { |_, v| Array(v).size == 1 } && included.any?
            included
          else
            rows + included
          end
        end

        def without_excluded(rows)
          rows.delete_if { |row| excluded?(row) }
        end

        def with_env_arrays(rows)
          rows.each { |row| row[:env] = Array(row[:env]) if row[:env] }
        end

        def with_global_env(rows)
          rows.each { |row| (row[:env] ||= []).concat(global_env) } if global_env
          rows
        end

        def with_shared(rows)
          rows.map { |row| shared.merge(row) }
        end

        def with_os(rows)
          return rows unless config[:os]
          rows.map do |row|
            { os: Array(config[:os]).first }.merge(row)
          end
        end

        def with_arch(rows)
          return rows unless config[:arch]
          rows.map do |row|
            { arch: Array(config[:arch]).first }.merge(row)
          end
        end

        def with_default(rows)
          rows << shared if rows.empty?
          rows
        end

        def included
          return [] unless config[:matrix]
          [config[:matrix][:include] || []].flatten
        end

        def excluded
          return [] unless config[:matrix]
          [config[:matrix][:exclude] || []].flatten
        end

        def excluded?(row)
          excluded.any? { |excluded| excluded.all? { |key, value| row[key] == value } }
        end

        def global_env
          config[:env] && config[:env].is_a?(Hash) && config[:env][:global]
        end

        def values
          values = config.select { |key, value| keys.include?(key) && ![[], nil].include?(value) }
          values = values.map { |key, value| key == :env && value.is_a?(Hash) ? value[:matrix] : value }
          values = values.map { |value| Array(value) }
          values
        end

        def shared
          @shared ||= config.reject { |key, value| key == :matrix || keys.include?(key) || [[], nil].include?(value) }
        end

        def cleaned(rows)
          rows.map { |row| except(row, :version) }
        end

        def uniq(rows)
          keys = rows.map(&:keys).flatten.uniq
          rows.each.with_index do |one, i|
            rows.delete_if.with_index do |other, j|
              only(other, *keys) == only(one, *keys) unless i == j
            end
          end
        end

        def keys
          @keys ||= (config.keys & expand_keys).select { |k| ![[], nil].include?(config[k]) }
        end

        def expand_keys
          Yml.expand_keys
        end
    end
  end
end
