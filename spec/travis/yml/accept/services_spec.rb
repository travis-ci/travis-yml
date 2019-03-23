describe Travis::Yml, 'services' do
  subject { described_class.apply(parse(yaml)) }

  known = %w(
    cassandra
    couchdb
    docker
    elasticsearch
    memcached
    mongodb
    mysql
    neo4j
    postgresql
    rabbitmq
    redis
    riak
  )

  known.each do |value|
    describe "given #{value}" do
      yaml %(
        services: #{value}
      )
      it { should serialize_to services: [value] }
      it { should_not have_msg }
    end
  end

  describe 'given an alias' do
    yaml %(
      services: postgres
    )
    it { should serialize_to services: ['postgresql'] }
  end

  describe 'given a seq' do
    yaml %(
      services:
      - redis
      - postgres
    )
    it { should serialize_to services: ['redis', 'postgresql'] }
  end

  describe 'typo' do
    yaml %(
      services: redes
    )
    it { should serialize_to services: ['redis'] }
  end
end
