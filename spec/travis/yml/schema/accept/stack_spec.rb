describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'stack' do
    it { should validate stack: 'onion' }
    it { should validate stack: 'cookiecat' }

    it { should_not validate stack: 'not-a-stack' }
    it { should_not validate stack: ['onion'] }
    it { should_not validate stack: [name: 'onion'] }
  end

  # TODO shouldn't this be allowed?
  #
  # describe 'matrix' do
  #   %i(matrix).each do |matrix| # TODO alias jobs
  #     %i(include exclude).each do |key|
  #       describe 'stack (on a hash)' do
  #         it { should validate matrix => { key => { stack: 'onion' } } }
  #         it { should_not validate matrix => { key => { stack: 'not-a-stack' } } }
  #       end
  #
  #       describe 'stack (on an array of hashes)' do
  #         it { should validate matrix => { key => [stack: 'onion'] } }
  #         it { should_not validate matrix => { key => [stack: 'not-a-stack'] } }
  #       end
  #     end
  #   end
  # end
end
