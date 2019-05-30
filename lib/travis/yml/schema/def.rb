require 'travis/yml/schema/def/root'

module Travis
  module Yml
    module Schema
      module Def
        extend self

        def define
          # types.each do |type|
          #   type.before_define if type.respond_to?(:before_define)
          #   type.define if type.respond_to?(:define)
          #   type.after_define if type.respond_to?(:after_define)
          # end
        end

        def root
          Type::Node.build(:root)
          # Def::Root.new
        end

        def types
          Type::Node.registries.sort.map(&:last).map(&:values).flatten
        end
      end
    end
  end
end
