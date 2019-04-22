describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'os' do
    it { should validate os: 'linux' }
    it { should validate os: 'osx' }
    it { should validate os: ['linux'] }
    it { should_not validate os: 'not-an-os' }
    it { should_not validate os: [name: 'linux'] }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'os (on a hash)' do
          it { should validate matrix => { key => { os: 'linux' } } }
          xit { should_not validate matrix => { key => { os: 'not-an-os' } } }
        end

        describe 'os (on an array of hashes)' do
          it { should validate matrix => { key => [os: 'linux'] } }
          xit { should_not validate matrix => { key => [os: 'not-an-os'] } }
        end
      end
    end
  end
end
