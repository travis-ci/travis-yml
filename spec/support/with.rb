module Spec
  module Support
    module With
      def self.included(const)
        const.extend(ClassMethods)
      end

      module ClassMethods
        def with(opts, &block)
          yield if opts.all? { |key, value| metadata[key] == value }
        end
      end
    end
  end
end

