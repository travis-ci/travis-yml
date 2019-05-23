# frozen_string_literal: true
require 'travis/yml/schema/dsl/seq'
require 'travis/yml/schema/dsl/str'

module Travis
  module Yml
    module Schema
      module Def
        class Services < Dsl::Seq
          register :services

          def define
            summary 'Services to set up and start'
            normal
            export
            type Service
          end
        end

        class Service < Dsl::Str
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
