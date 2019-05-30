require 'forwardable'

module Travis
  module Yml
    module Schema
      module Type
        module Opts
          def self.included(const)
            const.define_singleton_method :opt_names do |names = nil|
              return const.instance_variable_get(:@opt_names) unless names

              names = const.superclass.opt_names + names if const.superclass.respond_to?(:opt_names)
              dups = names.select{ |opt| names.count(opt) > 1 }.uniq
              raise "duplicate opt names on #{const}: #{dups}" if dups.any?

              const.instance_variable_set(:@opt_names, names.uniq)
            end
          end
        end
      end
    end
  end
end
