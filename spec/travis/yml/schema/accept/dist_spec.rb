describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'dist' do
    it { should validate dist: 'precise' }
    it { should validate dist: 'focal' }

    it { should_not validate dist: 'not-a-dist' }
    it { should_not validate dist: ['precise'] }
    it { should_not validate dist: [name: 'precise'] }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'dist' do
          it { should validate matrix => { key => { dist: 'precise' } } }
          xit { should_not validate matrix => { key => { dist: 'not-a-dist' } } }

          it { should validate matrix => { key => [dist: 'precise'] } }
          xit { should_not validate matrix => { key => [dist: 'not-a-dist'] } }
        end
      end
    end
  end
end
