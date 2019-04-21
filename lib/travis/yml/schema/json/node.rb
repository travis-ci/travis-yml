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

          def_delegators :node, :description, :export?, :id, :namespace, :title, :type

          def schema
            export? ? ref : to_h
          end

          def definitions
            export? ? defn(to_h) : {}
          end

          private

            def defn(schema)
              { namespace => { id => meta.merge(schema) } }
            end

            def meta
              compact('$id': id, title: title, description: description)
            end

            def ref(*args)
              opts = args.last.is_a?(Hash) ? args.pop : {}
              type = args.first || [namespace, id].join('/')
              { '$ref': "#/definitions/#{type}" }.merge(opts)
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

            def jsons(nodes)
              nodes.map { |node| json(node) }
            end

            def json(node)
              Json::Node[node.type].new(node)
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
