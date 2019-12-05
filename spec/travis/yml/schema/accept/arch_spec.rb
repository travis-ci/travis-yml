describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'arch' do
    it { should validate arch: 'amd64' }
    it { should validate arch: 'ppc64le' }
    it { should validate arch: 's390x' }
    it { should validate arch: ['amd64'] }

    it { should_not validate arch: 'not-an-arch' }
    it { should_not validate arch: [name: 'amd64'] }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'arch' do
          it { should validate matrix => { key => { arch: 'amd64' } } }
          xit { should_not validate matrix => { key => { arch: 'not-an-arch' } } }

          it { should validate matrix => { key => [arch: 'amd64'] } }
          xit { should_not validate matrix => { key => [arch: 'not-an-arch'] } }
        end
      end
    end
  end
end
