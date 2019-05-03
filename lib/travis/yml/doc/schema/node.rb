# frozen_string_literal: true
require 'registry'
require 'travis/yml/doc/helper/match'

module Travis
  module Yml
    module Doc
      module Schema
        class Node < Obj.new(:opts)
          include Registry

          def self.opts
            @opts ||= %i(id type aliases changes deprecated flags normal only
              except required strict unique)
          end

          def initialize(opts)
            validate_opts(opts)
            super
          end

          attr_writer :opts

          def matches?(value)
            value && value.is?(type) || value.none?
          end

          def id
            opts[:id]
          end

          def type
            opts[:type]
          end

          def is?(type)
            self.type == type
          end

          %i(bool num str enum seq map mapping schema all one).each do |type|
            define_method(:"#{type}?") { is?(type) }
          end

          def any?(&block)
            raise 'overwrite this method to accept a block' if block
            is?(:any)
          end

          def aliases
            opts[:aliases] ||= []
          end

          def inherit?
            change?(:inherit)
          end

          def change?(change)
            !!change(change)
          end

          def change(change)
            Array(opts[:changes]).detect { |opt| opt[:change] == change }
          end

          def changes
            opts[:changes]
          end

          def default?
            false
          end

          def deprecated?
            !!opts[:deprecated]
          end

          def deprecation
            opts[:deprecated]
          end

          def edge?
            flags.include?(:edge)
          end

          def flags
            opts[:flags] ||= []
          end

          def normal?
            !!opts[:normal]
          end

          def scalar?
            false
          end

          def secure?
            false
          end

          def strict?
            false?(opts[:strict]) ? false : true
          end
          memoize :strict?

          def prefix?
            !!prefix
          end

          def prefix
            opts[:prefix]
          end

          def required?
            !!opts[:required]
          end

          def unique?
            !!opts[:normal]
          end

          def match(strs, str)
            Match.new(strs.map(&:to_s), str.to_s, self).run
          end

          STOP = {
            from: %w(
              after_vendor
              branch
              branches
              erlang
              gcc
              golang
              html
              jvm
              nvm
              osx
              pip
              pgsql
              postgres
              prose
              sdk
              slack
              start_script
              test
              trusty
              versions
              vimscript
            ),
            to: %w(
              elm_test
            )
          }

          def stop?(from, to = nil)
            stop[:from].include?(from.to_s) || to && stop[:to].include?(to.to_s)
          end

          def stop
            { from: STOP[:from] + Yml.keys.map(&:to_s), to: STOP[:to] }
          end
          memoize :stop

          def all_keys
            []
          end

          def supports
            only(opts, :only, :except)
          end

          def validate_opts(opts)
            keys = opts.keys - self.class.opts
            raise "Unknown opts on #{type}: #{keys}" if keys.any?
          end

          def dup
            node = super
            node.opts = node.opts.dup
            node
          end

          def to_h
            compact(id: id, key: key, type: type, opts: opts)
          end

          def inspect
            type = self.class.name.sub('Travis::Yml::Doc::', '')
            pairs = compact(
              id: id,
              map: (map? && map.keys.any?) ? map.map { |key, obj| [key, obj.class.name.sub('Travis::Yml::Doc::Schema::', '').downcase.to_sym] }.to_h : nil,
              # schemas: respond_to?(:schemas) && schemas ? "[#{schemas.map(&:inspect).join(', ')}]" : nil,
              # schema: respond_to?(:schema) ? schema.inspect : nil,
              opts: opts.any? ? opts : nil
            )
            '#<%s %s>' % [type, pairs.map { |pair| pair.join('=') }.join(' ')]
          end
        end
      end
    end
  end
end
