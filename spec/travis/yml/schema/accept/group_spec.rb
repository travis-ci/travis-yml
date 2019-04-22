describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'group' do
    it { should validate group: 'stable' }
    it { should validate group: 'pre' }

    it { should_not validate group: true }
    it { should_not validate group: 1 }
    it { should_not validate group: ['stable'] }
    it { should_not validate group: [name: 'stable'] }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'group (on a hash)' do
          it { should validate matrix => { key => { group: 'stable' } } }
          xit { should_not validate matrix => { key => { group: true } } }
        end

        describe 'group (on an array of hashes)' do
          it { should validate matrix => { key => [group: 'stable'] } }
          xit { should_not validate matrix => { key => [group: true] } }
        end
      end
    end
  end
end
