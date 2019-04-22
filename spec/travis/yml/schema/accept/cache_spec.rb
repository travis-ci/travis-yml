describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'cache' do
    types = %i(apt bundler cargo ccache cocoapods npm packages pip yarn)
    types.each do |type|
      it { should validate cache: { type => true } }
      it { should_not validate cache: { type => 'foo' } }
    end

    it { should validate cache: { directories: './foo' } }
    it { should validate cache: { directories: ['./foo'] } }
    it { should_not validate cache: { directories: { foo: './foo' } } }
    it { should_not validate cache: { directories: [ foo: './foo' ] } }

    it { should validate cache: { timeout: 10 } }
    it { should_not validate cache: { timeout: '10' } }
    it { should_not validate cache: { timeout: { value: 10 } } }
    it { should_not validate cache: { timeout: [ value: 10 ] } }
  end

  describe 'matrix' do
    %i(matrix).each do |matrix| # TODO alias jobs
      %i(include exclude).each do |key|
        describe 'cache' do
          it { should validate matrix => { key => { cache: { bundler: true } } } }
          it { should validate matrix => { key => [ cache: { bundler: true } ] } }
        end
      end
    end
  end
end
