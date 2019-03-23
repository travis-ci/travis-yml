describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:haskell]) }

  describe 'haskell' do
  end
end
