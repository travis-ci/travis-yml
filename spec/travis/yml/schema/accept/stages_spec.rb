describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'stages' do
    it { should validate stages: 'one' }
    it { should validate stages: ['one', 'two'] }
    it { should validate stages: { name: 'one', if: 'branch = master' } }
    it { should validate stages: [name: 'one', if: 'branch = master'] }

    it { should_not validate stages: [foo: 'one'] }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'stage' do
          xit { should validate matrix => { key => { stage: 'one' } } } # TODO
          it { should validate matrix => { key => { stage: { name: 'one', if: 'branch = master' } } } }
          it { should_not validate matrix => { key => { stage: ['one', 'two'] } } }
          it { should_not validate matrix => { key => { stage: [foo: 'one'] } } }
        end
      end
    end
  end
end
