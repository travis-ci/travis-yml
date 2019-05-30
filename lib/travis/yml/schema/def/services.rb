# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Services < Type::Seq
          register :services

          def define
            summary 'Services to set up and start'
            normal
            export
            type :service
          end
        end

        class Service < Type::Str
          register :service

          def define
            downcase

            value :cassandra
            value :couchdb
            value :docker
            value :elasticsearch
            value :memcached,  alias: :memcache
            value :mongodb
            value :mysql
            value :neo4j
            value :postgresql, alias: :postgres
            value :rabbitmq,   alias: :'rabbitmq-server'
            value :redis,      alias: :'redis-server'
            value :riak
            value :xvfb,       only: { dist: 'xenial' }

            export
          end
        end
      end
    end
  end
end
