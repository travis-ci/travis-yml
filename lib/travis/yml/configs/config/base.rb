require 'forwardable'
require 'travis/yml/helper/obj'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/ref'

module Travis
  module Yml
    module Configs
      module Config
        module Base
          extend Forwardable
          include Helper::Obj, Errors, Memoize

          def_delegators :ctx, :data, :opts, :msgs, :msg
          def_delegators :repo, :allow_config_imports?, :owner_name, :private?, :public?

          attr_reader :on_loaded

          def api?
            false
          end

          def travis_yml?
            false
          end

          def repo
            @repo ||= ctx.repos[slug]
          end

          def config
            @config ||= {}
          end

          def part
            Parts::Part.new(raw, source, mode)
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
            imports = Array(config['import'])
            imports = imports.select { |import| import.is_a?(Hash) }
            imports.map { |import| Config::File.new(ctx, self, import) }
          end
          memoize :imports

          # Flattening the tree should result in a unique array of configs
          # ordered by the order resulting in walking the tree depth-first.
          # However, we load the tree breadth-first and load times vary.
          # Configs with the same source are only loaded once. So, nodes that
          # are supposed to be kept in a higher order position may not have
          # been loaded.
          #
          # For example:
          #
          #   - a
          #     - a.1
          #       - x
          #   - b
          #     - x
          #
          # We load a and b in parallel. a then loads a.1, which then tries to
          # load x. However, in the meantime b will have loaded x already, so
          # a.1 will end up with an x that has not been loaded.
          #
          # Therefor we swap nodes that have not been loaded but need to be
          # kept with nodes that have been loaded but needed to be uniq'ed
          # away.
          def flatten
            return [] if errored? || circular? || !matches?
            configs = sort([self].compact + imports.map(&:flatten).flatten)
            configs.uniq(&:to_s).reject(&:skip?)
          end

          def sort(configs)
            configs.dup.each.with_index do |lft, i|
              next if lft.loaded?
              rgt = configs.detect { |rgt| lft.to_s == rgt.to_s && rgt.loaded? }
              configs[i] = configs.delete(rgt)
            end
          end

          def circular?
            parents.map(&:to_s).include?(to_s)
          end

          def matches?
            return true if Condition.new(import['if'], import, data).accept?
            msg :info, :import, :skip_import, source: to_s, condition: import['if']
            false
          end
          memoize :matches?

          def root
            root? ? self : parent.root
          end

          def root?
            parent.nil?
          end

          def parents
            root? ? [] : parent.parents + [parent]
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
            raw.nil? || raw.strip.empty?
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

          def to_h
            config
          end

          def serialize
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

            def validate
              return true if root?
              invalid_ownership if invalid_ownership?
              invalid_visibility if invalid_visibility?
              not_allowed if not_allowed?
              !errored?
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

            def invalid_ownership
              error :import, :invalid_ownership, owner: repo.owner_name
            end

            def invalid_visibility
              error :import, :invalid_visibility, repo: slug
            end

            def not_allowed
              error :import, :import_not_allowed, repo: slug
            end

            def required?
              !parent&.api? || !travis_yml?
            end

            def errored?
              !!@errored
            end

            def secure?(obj)
              case obj
              when Hash
                obj.key?('secure') || obj.any? { |_, obj| secure?(obj) }
              when Array
                obj.any? { |obj| secure?(obj) }
              else
                false
              end
            end

            def error(*msg)
              @errored = true
              ctx.error(*msg)
            end

            def parse(str)
              return unless str
              opts = OPTS.keys.zip(Array.new(OPTS.size) { false }).to_h
              doc = Yml.load(str, opts)
              msgs.concat(doc.msgs)
              doc.serialize(false)
            end
        end
      end
    end
  end
end
