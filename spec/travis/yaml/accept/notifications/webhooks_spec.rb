describe Travis::Yaml, 'notifications: webhooks' do
  let(:msgs)     { subject.msgs }
  let(:webhooks) { subject.to_h[:notifications][:webhooks] }

  subject { described_class.apply(config) }

  describe 'given a string' do
    let(:config) { { notifications: { webhooks: 'url' } } }
    it { expect(webhooks).to include(urls: ['url']) }
  end

  describe 'given an array' do
    let(:config) { { notifications: { webhooks: ['url'] } } }
    it { expect(webhooks).to include(urls: ['url']) }
  end

  describe 'given a hash with a string' do
    let(:config) { { notifications: { webhooks: { urls: 'url' } } } }
    it { expect(webhooks).to include(urls: ['url']) }
  end

  describe 'given a hash with a secure' do
    let(:config) { { notifications: { webhooks: { urls: { secure: 'url' } } } } }
    it { expect(webhooks).to include(urls: [secure: 'url']) }
  end

  describe 'given a hash with an array' do
    let(:config) { { notifications: { webhooks: { urls: ['url'] } } } }
    it { expect(webhooks).to include(urls: ['url']) }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { webhooks: { callback.to_sym => value } } } }
            it { expect(webhooks[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { webhooks: { urls: 'urls' }, callback.to_sym => value } } }
            it { expect(webhooks[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
