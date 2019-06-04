require 'forwardable'

module Travis
  module Yml
    module Schema
      module Type
        module Opts
          def self.included(const)
            class << const
              def opts(opts = nil)
                return @opts ||= superclass.respond_to?(:opts) ? superclass.opts : [] unless opts
                opts = superclass.opts + opts if superclass.respond_to?(:opts)
                dups = opts.select{ |opt| opts.count(opt) > 1 }.uniq
                raise "duplicate opt names on #{const}: #{dups}" if dups.any?
                @opts = opts
              end
            end
          end
        end
      end
    end
  end
end
