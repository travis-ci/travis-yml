describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'sudo' do
    it { should validate sudo: false }
    it { should validate sudo: true }
    it { should validate sudo: 'false' }
    it { should validate sudo: 'true' }
    it { should validate sudo: 'required' }

    xit { should_not validate sudo: 'not-a-sudo' }
    it { should_not validate sudo: ['true'] }
    it { should_not validate sudo: [on: 'true'] }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'sudo (on a hash)' do
          it { should validate matrix => { key => { sudo: true } } }
          xit { should_not validate matrix => { key => { sudo: [true] } } }
        end

        describe 'sudo (on an array of hashes)' do
          it { should validate matrix => { key => [sudo: true] } }
          xit { should_not validate matrix => { key => [sudo: [true]] } }
        end
      end
    end
  end
end
