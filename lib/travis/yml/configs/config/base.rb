require 'forwardable'
require 'travis/yml/helper/obj'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/ref'
require 'travis/yml/parts'

module Travis
  module Yml
    module Configs
      module Config
        def self.travis_yml(ctx, parent, slug, ref, mode)
          Config::File.new(ctx, parent, source: "#{slug}:.travis.yml@#{ref}", mode: mode)
        end

        module Base
          extend Forwardable
          include Helper::Obj, Errors, Memoize

          def_delegators :ctx, :data, :opts
          def_delegators :repo, :allow_config_imports?, :owner_name, :private?, :public?

          attr_reader :on_loaded

          def repo
            @repo ||= ctx.repos[slug]
          end

          def config
            @config ||= {}
          end

          def part
            Parts::Part.new(raw, source, mode) # TODO can Config and Part be joined?
          end

          def load(&block)
            @on_loaded = block if root?
          end

          def loaded
            @loaded = true
            return root.loaded unless root?
            return unless loaded?
            on_loaded.call
          end

          def imports
            imports = Array(config[:import])
            imports = imports.select { |import| import.is_a?(Hash) }
            imports.map { |import| Config::File.new(ctx, self, import) }
          end
          memoize :imports

          def flatten
            skip? ? [] : [self].compact + imports.map(&:flatten).flatten
          end

          def matches?
            return true if Condition.new(import, data).accept?
            msg :info, :import, :skip_import, source: to_s, condition: import[:if]
            false
          end

          def validate
            return if root?
            invalid_ownership(repo) if invalid_ownership?
            invalid_visibility(repo) if invalid_visibility?
            not_allowed(repo) if not_allowed?
          end

          def root
            root? ? self : parent.root
          end

          def root?
            parent.nil?
          end

          def local?
            !parent || parent.repo == repo
          end

          def remote?
            !local?
          end

          def reencrypt?
            same_owner?(root) && remote? && secure?(config)
          end

          def same_owner?(other)
            repo.owner_name == other.owner_name
          end

          def empty?
            raw.nil? || raw.empty?
          end

          def skip
            @skip = true
          end

          def skip?
            !!@skip
          end

          def loaded?
            skip? || !!@loaded && imports.all?(&:loaded?)
          end

          def mode
            super&.to_sym
          end

          def to_h
            {
              source: to_s,
              config: raw,
              mode: mode
            }
          end

          private

            def store
              ctx.fetch.store(self)
            end

            def msg(*msg)
              msgs << msg
            end

            def msgs
              ctx.fetch.msgs
            end

            def invalid_ownership?
              parent.private? && private? && parent.owner_name != owner_name
            end

            def invalid_visibility?
              parent.public? && private?
            end

            def not_allowed?
              remote? && private? && !allow_config_imports?
            end

            def secure?(obj)
              case obj
              when Hash
                obj.key?(:secure) || obj.any? { |_, obj| secure?(obj) }
              when Array
                obj.any? { |obj| secure?(obj) }
              else
                false
              end
            end

            def parse(str)
              Yml.load(str, defaults: false).serialize
            end
        end
      end
    end
  end
end
