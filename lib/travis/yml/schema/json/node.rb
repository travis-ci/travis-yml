# frozen_string_literal: true
require 'forwardable'
require 'registry'

module Travis
  module Yml
    module Schema
      module Json
        class Node < Obj.new(:node)
          extend Forwardable
          include Registry

          registry :type

          def_delegators :node, :description, :export?, :id, :namespace, :title, :type

          def schema
            to_h
          end

          def definition
            meta.merge(to_h)
          end

          def full_id
            [namespace, id].join(':').to_sym
          end

          private

            def meta
              id = namespace == :type ? node.id : :"#{namespace}_#{node.id}"
              compact('$id': id, title: title, description: description)
            end

            def normals?(schemas)
              schemas.any? { |schema| schema[:normal] }
            end

            def normals(schemas)
              return schemas if normals?(schemas)
              schemas.map.with_index do |schema, ix|
                ix == 0 ? normal(schema) : denormal(schema)
              end
            end

            def normal(schema)
              schema.merge(normal: true)
            end

            def denormal(schema)
              except(schema, :normal)
            end

            def opts
              @opts ||= compact(remap(node.opts.to_h))
            end

            def remap(opts)
              opts
            end
        end
      end
    end
  end
end
