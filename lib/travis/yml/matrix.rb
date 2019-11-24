# frozen_string_literal: true

require 'travis/yml/helper/condition'

module Travis
  module Yml
    class Matrix < Obj.new(:config, :data)
      def rows
        rows = expand
        rows = with_included(rows)
        rows = with_default(rows)
        rows = without_excluded(rows)
        rows = with_env_arrays(rows)
        rows = with_global_env(rows)
        rows = with_first_env(rows)
        rows = with_shared(rows)
        rows = with_global(rows)
        rows = without_unsupported(rows)
        rows = cleaned(rows)
        rows = uniq(rows)
        rows
      end

      def axes
        keys
      end

      private

        def expand
          rows = wrap(values.inject { |lft, rgt| lft.product(rgt) } || [])
          rows = rows.map { |row| keys.zip(wrap(row).flatten).to_h }
          rows
        end

        def with_included(rows)
          # If there's one row at this point, and it has single-entry
          # expand values, and we also have matrix includes, remove the row
          # because it's probably an unnecessary duplicate.
          # TODO: verify this
          if rows.size == 1 && only(rows.first, *expand_keys).all? { |_, v| wrap(v).size == 1 } && included.any?
            included
          else
            rows + included
          end
        end

        def without_excluded(rows)
          rows.delete_if { |row| excluded?(row) }
        end

        def with_env_arrays(rows)
          rows.each { |row| row[:env] = wrap(row[:env]) if row[:env] }
        end

        def with_global_env(rows)
          rows.each { |row| (row[:env] ||= []).concat(global_env).uniq! } if global_env
          rows
        end

        # The legacy implementation picked the first env var out of `env.jobs` if
        # jobs listed in `jobs.include` if they do not define a key `env` already.
        def with_first_env(rows)
          rows.each { |row| (row[:env] ||= []).concat([first_env]).uniq! unless row[:env] } if first_env
          rows
        end

        def with_shared(rows)
          rows.map { |row| shared.merge(row) }
        end

        def with_global(rows)
          rows.map do |row|
            global.inject(row) do |row, (key, value)|
              row[key] ||= value
              row
            end
          end
        end

        def global
          global = config.select { |key, _| key != :env && keys.include?(key) }.to_h
          global.map { |key, value| [key, wrap(value).first] }.to_h
        end

        def without_unsupported(rows)
          rows.map do |row|
            row.delete(:osx_image) unless row[:os] == 'osx'
            row.delete(:arch) unless row[:os] == 'linux'
            row
          end
        end

        def with_default(rows)
          rows << shared if rows.empty?
          rows
        end

        def included
          return [] unless config.is_a?(Hash) && config[:jobs].is_a?(Hash)
          [config[:jobs][:include] || []].flatten.select { |row| row.is_a?(Hash) }
        end

        def excluded
          return [] unless config.is_a?(Hash) && config[:jobs].is_a?(Hash)
          [config[:jobs][:exclude] || []].flatten
        end

        def excluded?(row)
          excluded.any? do |excluded|
            next unless excluded.respond_to?(:all?)
            next unless Condition.new(excluded, data).accept?
            except(excluded, :if).all? { |key, value| wrap(row[key]) == wrap(value) }
          end
        end

        def global_env
          config[:env] && config[:env].is_a?(Hash) && config[:env][:global]
        end

        def first_env
          case env = config[:env]
          when Array
            env.first
          when Hash
            env.fetch(:jobs, nil)&.first
          end
        rescue nil
        end

        def values
          values = config.select { |key, value| keys.include?(key) && ![[], nil].include?(value) }
          values = values.map { |key, value| key == :env && value.is_a?(Hash) && value.key?(:jobs) ? value[:jobs] : value }
          values = values.map { |value| wrap(value) }
          values
        end

        def shared
          @shared ||= config.reject { |key, value| key == :jobs || keys.include?(key) || [[], nil].include?(value) }
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
          Yml.expand_keys - [:jobs] + [:env] # TODO
        end

        def wrap(obj)
          obj.is_a?(Array) ? obj : [obj]
        end
    end
  end
end
