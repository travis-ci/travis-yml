require 'travis/yaml/support/obj'

module Travis
  module Yaml
    class Matrix < Obj.new(:spec, :config)
      def rows
        rows = expand
        rows = rows + included
        rows = with_default(rows)
        rows = without_excluded(rows)
        rows = with_env_arrays(rows)
        rows = with_global_env(rows)
        rows = with_shared(rows)
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

        def with_default(rows)
          rows << shared if rows.empty?
          rows
        end

        def included
          config[:matrix] && config[:matrix][:include] || []
        end

        def excluded
          config[:matrix] && config[:matrix][:exclude] || []
        end

        def excluded?(row)
          excluded.any? { |excluded| excluded.all? { |key, value| row[key] == value } }
        end

        def global_env
          config[:env] && config[:env].is_a?(Hash) && config[:env][:global]
        end

        def values
          values = config.select { |key, _| keys.include?(key) }
          values = values.map { |key, value| key == :env && value.is_a?(Hash) ? value[:matrix] : value }
          values = values.map { |value| Array(value) }
          values
        end

        def shared
          @shared ||= config.reject { |key, _| key == :matrix || keys.include?(key) }
        end

        def uniq(rows)
          rows.each.with_index do |one, i|
            rows.delete_if.with_index do |other, j|
              keys  = other.keys & one.keys
              other == one.select { |key, _| keys.include?(key) } unless i == j
            end
          end
        end

        def keys
          @keys ||= config.keys & expand_keys
        end

        def expand_keys
          spec[:expand] || []
        end
    end
  end
end
