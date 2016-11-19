describe Travis::Yaml::Spec::Def::Services do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :services,
      type: :seq,
      types: [
        {
          name: :service,
          type: :fixed,
          downcase: true,
          values: [
            { value: 'cassandra' },
            { value: 'couchdb' },
            { value: 'docker' },
            { value: 'elasticsearch' },
            { value: 'memcached', alias: ['memcache'] },
            { value: 'mongodb' },
            { value: 'mysql' },
            { value: 'neo4j' },
            { value: 'postgresql', alias: ['postgres'] },
            { value: 'rabbitmq' },
            { value: 'redis-server', alias: ['redis'] },
            { value: 'riak' },
          ]
        }
      ]
    )
  end
end

