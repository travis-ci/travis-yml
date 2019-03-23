# frozen_string_literal: true
require 'travis/yaml/spec/type/seq'
require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Services < Type::Seq
          register :services

          def define
            type Service
          end
        end

        class Service < Type::Fixed
          register :service

          def define
            downcase

            value :cassandra
            value :couchdb
            value :docker
            value :elasticsearch
            value :memcached,      alias: :memcache
            value :mongodb
            value :mysql
            value :neo4j
            value :postgresql,     alias: :postgres
            value :rabbitmq,       alias: :'rabbitmq-server'
            value :'redis-server', alias: :redis
            value :riak
          end
        end
      end
    end
  end
end
