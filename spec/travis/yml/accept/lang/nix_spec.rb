describe Travis::Yml, 'nix' do
  subject { described_class.apply(parse(yaml)) }
end
