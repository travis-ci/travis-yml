describe Travis::Yml, 'c' do
  subject { described_class.apply(parse(yaml)) }
end
