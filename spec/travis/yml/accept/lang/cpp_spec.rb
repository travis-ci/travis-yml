describe Travis::Yml, 'cpp' do
  subject { described_class.apply(parse(yaml)) }
end
