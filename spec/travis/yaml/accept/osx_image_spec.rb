describe Travis::Yaml, 'osx_image' do
  let(:msgs) { subject.msgs }
  let(:osx_image) { subject.to_h[:osx_image] }

  subject { described_class.apply(input) }

  describe 'given a string' do
    let(:input) { { osx_image: 'xcode8.2' } }
    it { expect(osx_image).to eq 'xcode8.2' }
  end
end
