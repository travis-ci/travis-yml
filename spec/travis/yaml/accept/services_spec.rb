describe Travis::Yaml, 'services' do
  let(:msgs) { subject.msgs.reject { |msg| msg.first == :info } }
  let(:services) { subject.to_h[:services] }

  subject { described_class.apply(input) }

  describe 'accepts cassandra' do
    let(:input) { { services: ['cassandra'] } }
    it { expect(services).to eq ['cassandra'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts couchdb' do
    let(:input) { { services: ['couchdb'] } }
    it { expect(services).to eq ['couchdb'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts docker' do
    let(:input) { { services: ['docker'] } }
    it { expect(services).to eq ['docker'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts elasticsearch' do
    let(:input) { { services: ['elasticsearch'] } }
    it { expect(services).to eq ['elasticsearch'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts memcached' do
    let(:input) { { services: ['memcached'] } }
    it { expect(services).to eq ['memcached'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts memcache (alias)' do
    let(:input) { { services: ['memcache'] } }
    it { expect(services).to eq ['memcached'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts mongodb' do
    let(:input) { { services: ['mongodb'] } }
    it { expect(services).to eq ['mongodb'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts mysql' do
    let(:input) { { services: ['mysql'] } }
    it { expect(services).to eq ['mysql'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts neo4j' do
    let(:input) { { services: ['neo4j'] } }
    it { expect(services).to eq ['neo4j'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts postgresql' do
    let(:input) { { services: ['postgresql'] } }
    it { expect(services).to eq ['postgresql'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts postgres (alias)' do
    let(:input) { { services: ['postgres'] } }
    it { expect(services).to eq ['postgresql'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts rabbitmq' do
    let(:input) { { services: ['rabbitmq'] } }
    it { expect(services).to eq ['rabbitmq'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts redis-server' do
    let(:input) { { services: ['redis-server'] } }
    it { expect(services).to eq ['redis-server'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts redis (alias)' do
    let(:input) { { services: ['redis'] } }
    it { expect(services).to eq ['redis-server'] }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts riak' do
    let(:input) { { services: ['riak'] } }
    it { expect(services).to eq ['riak'] }
    it { expect(msgs).to be_empty }
  end
end
