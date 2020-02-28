# frozen_string_literal: true

require 'travis/yml/helper/condition'
require 'travis/yml/helper/obj'

module Travis
  module Yml
    class Matrix < Obj.new(:config, :data)
      include Helper::Obj

      def jobs
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
        rows = filter(rows)
        rows
      end
      alias rows jobs

      def axes
        keys
      end

      def msgs
        @msgs ||= []
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
          rows.each { |row| row[:env] = with_env_array(row[:env]) if row[:env] }
        end

        def with_env_array(env)
          case env
          when Hash  then compact(wrap(except(env, :global)))
          when Array then env.map { |env| with_env_array(env) }.flatten(1)
          else wrap(env)
          end
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
          rows.map { |row| row.select { |key, value| supported?(row, key, value) }.to_h }
        end

        def with_default(rows)
          rows << shared if rows.empty?
          rows
        end

        def included
          return [] unless config.is_a?(Hash) && config[:jobs].is_a?(Hash)
          rows = [config[:jobs][:include] || []].flatten.select { |row| row.is_a?(Hash) }
          with_stages(rows)
        end

        def with_stages(rows)
          rows.inject(nil) do |stage, row|
            row[:stage] ||= stage if stage
            row[:stage] || stage
          end
          rows
        end

        def excluded
          return [] unless config.is_a?(Hash) && config[:jobs].is_a?(Hash)
          [config[:jobs][:exclude] || []].flatten
        end

        def excluded?(row)
          excluded.any? do |excluded|
            next unless excluded.respond_to?(:all?)
            next unless accept?(:exclude, :'jobs.exclude', excluded)
            except(excluded, :if).all? { |key, value| wrap(row[key]) == wrap(value) }
          end
        end

        # move this to Yml::Doc.supported?
        def supported?(job, key, value)
          supporting = stringify(only(job, :language, :os, :arch))
          support = Yml.expand.support(key.to_s)
          Yml::Doc::Value::Support.new(support, supporting, value).supported?
        end

        def filter(rows)
          rows.select { |row| accept?(:job, :'jobs.include', row) }
        end

        def accept?(type, key, config, ix = 0)
          data = data_for(config)
          return true unless data
          return true if Condition.new(config, data).accept?
          msgs << [:info, key, :"skip_#{type}", number: ix + 1, condition: config[:if]]
          false
        end

        def data_for(config)
          only(config, *%i(language os dist env)).merge(data) if data
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
          values = only(config, *keys)
          values = values.map { |key, value| key == :env && value.is_a?(Hash) && value.key?(:jobs) ? value[:jobs] : value }
          values = values.map { |value| wrap(value) }
          values
        end

        def shared
          @shared ||= config.reject { |key, value| key == :jobs || keys.include?(key) || blank?(value) }
        end

        def cleaned(rows)
          # TODO are there other keys that do not make sense on a job config?
          rows.map { |row| except(row, :import, :stages, :notifications, :version) }
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
          @keys ||= (config.keys & expand_keys).reject { |key| blank?(config[key]) }
        end

        def expand_keys
          Yml.expand_keys - [:jobs] + [:env] # TODO allow nested matrix expansion keys, like env.jobs
        end

        def blank?(obj)
          case obj
          when Array, Hash, String then obj.empty?
          when NilClass then true
          else false
          end
        end

        def wrap(obj)
          obj.is_a?(Array) ? obj : [obj]
        end
    end
  end
end
