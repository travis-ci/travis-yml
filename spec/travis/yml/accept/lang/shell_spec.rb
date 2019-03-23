describe Travis::Yml, 'shell' do
  subject { described_class.apply(parse(yaml)) }
end
