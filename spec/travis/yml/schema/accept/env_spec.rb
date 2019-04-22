describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'env' do
    it { should validate env: 'FOO=foo' }
    it { should validate env: { secure: '1234' } }
    it { should validate env: { FOO: 'foo' } }
    it { should validate env: [ 'FOO=foo' ] }
    it { should validate env: [ 'FOO=foo', { BAR: 'bar' }, { secure: '1234' }] }

    it { should validate env: { matrix: 'FOO=foo' } }
    it { should validate env: { matrix: ['FOO=foo'] } }
    it { should validate env: { matrix: { FOO: 'foo' } } }
    it { should validate env: { matrix: { secure: '1234' } } }
    it { should validate env: { matrix: [ 'FOO=foo', { BAR: 'bar' }, { secure: '1234' } ] } }

    it { should validate env: { global: 'FOO=foo' } }
    it { should validate env: { global: [ 'FOO=foo' ] } }
    it { should validate env: { global: { FOO: 'foo' } } }
    it { should validate env: { global: { secure: '1234' } } }
    it { should validate env: { global: [ 'FOO=foo', { BAR: 'bar' }, { secure: '1234' } ] } }

    it { should_not validate env: 'FOO' }
    it { should_not validate env: { wat: { FOO: 'foo' } } }
    it { should_not validate env: [ wat: { FOO: 'foo' } ] }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'env (on a hash)' do
          it { should validate matrix => { key => { env: 'FOO=foo' } } }
          xit { should_not validate matrix => { key => { env: 'FOO' } } }
        end

        describe 'env (on an array of hashes)' do
          it { should validate matrix => { key => [env: 'FOO=foo'] } }
          xit { should_not validate matrix => { key => [env: 'FOO'] } }
        end
      end
    end
  end
end
