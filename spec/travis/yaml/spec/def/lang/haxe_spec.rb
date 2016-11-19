describe Travis::Yaml::Spec::Def::Haxe do
  let(:spec) { Travis::Yaml.spec }
  let(:lang) { spec[:map][:language][:types][0] }
  let(:haxe) { spec[:map][:haxe][:types][0] }
  let(:hxml) { spec[:map][:hxml][:types][0] }
  let(:neko) { spec[:map][:neko][:types][0] }
  
  it { expect(lang[:values]).to include(value: 'haxe') }
  it { expect(haxe[:only][:language]).to include('haxe') }
  it { expect(hxml[:only][:language]).to include('haxe') }
  it { expect(neko[:only][:language]).to include('haxe') }
end