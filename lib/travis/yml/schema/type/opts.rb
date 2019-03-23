require 'forwardable'

module Travis
  module Yml
    module Schema
      module Type
        module Opts
          def self.included(const)
            const.define_singleton_method :opts do |opts = nil|
              return const.instance_variable_get(:@opts) unless opts

              opts = const.superclass.opts + opts if const.superclass.respond_to?(:opts)
              dups = opts.select{ |opt| opts.count(opt) > 1 }.uniq
              raise "duplicate opts on #{const}: #{dups}" if dups.any?

              const.instance_variable_set(:@opts, opts.uniq)
            end
          end
        end
      end
    end
  end
end
