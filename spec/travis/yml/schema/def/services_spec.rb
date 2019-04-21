require 'travis/yml/schema/def/services'

describe Travis::Yml::Schema::Def::Services, 'structure' do
  describe 'definitions' do
    describe 'services' do
      subject { Travis::Yml.schema[:definitions][:type][:services] }
      # subject { described_class.new.definitions[:type][:services] }

      it do
        should eq(
          '$id': :services,
          title: 'Services',
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

    describe 'services' do
      subject { Travis::Yml.schema[:definitions][:type][:service] }

      it do
        should eq(
          '$id': :service,
          title: 'Service',
          type: :string,
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
            'riak'
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
          }
        )
      end
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/services'
      )
    end
  end
end
