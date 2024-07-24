require 'travis/yml/schema/def/services'

describe Travis::Yml::Schema::Def::Services do
  describe 'services' do
    subject { Travis::Yml.schema[:definitions][:type][:services] }

    it do
      should eq(
        '$id': :services,
        title: 'Services',
        summary: 'Services to set up and start',
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/service'
            },
            normal: true
          },
          {
            '$ref': '#/definitions/type/service'
          }
        ]
      )
    end
  end

  describe 'service' do
    subject { Travis::Yml.schema[:definitions][:type][:service] }

    it do
      should eq(
        '$id': :service,
        title: 'Service',
        type: :string,
        example: [
          'postgresql',
          'redis'
        ],
        enum: [
          'cassandra',
          'couchdb',
          'docker',
          'elasticsearch',
          'memcached',
          'mongodb',
          'mysql',
          'neo4j',
          'postgresql',
          'rabbitmq',
          'redis',
          'riak',
          'xvfb',
          'cri-dockerd'
        ],
        downcase: true,
        values: {
          memcached: {
            aliases: [
              'memcache'
            ]
          },
          postgresql: {
            aliases: [
              'postgres'
            ]
          },
          rabbitmq: {
            aliases: [
              'rabbitmq-server'
            ]
          },
          redis: {
            aliases: [
              'redis-server'
            ]
          },
          xvfb: {
            only: {
              dist: [
                'xenial'
              ]
            }
          },
        }
      )
    end
  end
end
