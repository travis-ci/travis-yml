describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'services' do
    it { should validate service: 'cassandra' }
    it { should validate service: 'couchdb' }
    it { should validate service: 'docker' }
    it { should validate service: 'elasticsearch' }
    it { should validate service: 'memcached' }
    it { should validate service: 'mongodb' }
    it { should validate service: 'mysql' }
    it { should validate service: 'neo4j' }
    it { should validate service: 'postgresql' }
    it { should validate service: 'rabbitmq' }
    it { should validate service: 'redis' }
    it { should validate service: 'riak' }
    it { should validate services: ['redis', 'postgresql'] }

    it { should_not validate services: 'not-a-service' }
    it { should_not validate services: ['not-a-service'] }
    it { should_not validate services: { name: 'redis' } }
    it { should_not validate services: [ name: 'redis' ] }
  end

  # TODO shouldn't this be allowed?
  #
  # describe 'matrix' do
  #   %i(matrix).each do |matrix| # TODO alias jobs
  #     %i(include exclude).each do |key|
  #       describe 'services (on a hash)' do
  #         it { should validate matrix => { key => { service: 'redis' } } }
  #         it { should_not validate matrix => { key => { service: 'not-a-service' } } }
  #       end
  #
  #       describe 'services (on an array of hashes)' do
  #         it { should validate matrix => { key => [service: 'redis'] } }
  #         it { should_not validate matrix => { key => [service: 'not-a-service'] } }
  #       end
  #     end
  #   end
  # end
end
