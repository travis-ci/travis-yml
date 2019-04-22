describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'git' do
    it { should validate git: { strategy: 'clone' } }
    it { should validate git: { strategy: 'tarball' } }
    it { should_not validate git: { strategy: 'not-a-strategy' } }
    it { should_not validate git: { strategy: ['clone'] } }
    it { should_not validate git: { strategy: { name: 'clone' } } }
    it { should_not validate git: { strategy: [ name: 'clone' ] } }

    it { should validate git: { quiet: true } }
    it { should_not validate git: { quiet: 'not-a-boolean' } }
    it { should_not validate git: { quiet: [true] } }
    it { should_not validate git: { quiet: { on: true } } }
    it { should_not validate git: { quiet: [ on: true ] } }

    it { should validate git: { depth: 1 } }
    it { should_not validate git: { depth: 'not-a-number' } }
    it { should_not validate git: { depth: [1] } }
    it { should_not validate git: { depth: { value: 1 } } }
    it { should_not validate git: { depth: [ value: 1 ] } }

    it { should validate git: { submodules: true } }
    it { should_not validate git: { submodules: 'not-a-boolean' } }
    it { should_not validate git: { submodules: [true] } }
    it { should_not validate git: { submodules: { on: true } } }
    it { should_not validate git: { submodules: [ on: true ] } }

    it { should validate git: { submodules_depth: 1 } }
    it { should_not validate git: { submodules_depth: 'not-a-number' } }
    it { should_not validate git: { submodules_depth: [1] } }
    it { should_not validate git: { submodules_depth: { value: 1 } } }
    it { should_not validate git: { submodules_depth: [ value: 1 ] } }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'env (on a hash)' do
          it { should validate matrix => { key => { git: { strategy: 'clone' } } } }
          xit { should_not validate matrix => { key => { git: { strategy: 'not-a-strategy' } } } }
        end

        describe 'env (on an array of hashes)' do
          it { should validate matrix => { key => [git: { strategy: 'clone' }] } }
          xit { should_not validate matrix => { key => [git: { strategy: 'not-a-strategy' }] } }
        end
      end
    end
  end
end
