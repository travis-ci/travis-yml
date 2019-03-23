describe Travis::Yaml, 'osx_image' do
  let(:value) { subject.serialize }

  subject { described_class.apply(input) }

  describe 'osx_image' do
    describe 'on osx' do
      let(:input) { { os: 'osx', osx_image: 'xcode8.2' } }
      it { expect(value[:osx_image]).to eq 'xcode8.2' }
      it { expect(info).to include [:info, :osx_image, :edge, given: :osx_image] }
    end

    describe 'on linux' do
      let(:input) { { os: 'linux', osx_image: 'xcode8.2' } }
      it { expect(value[:osx_image]).to be_nil }
      it { expect(msgs).to include [:error, :osx_image, :unsupported, on_key: :os, on_value: 'linux', key: :osx_image, value: 'xcode8.2'] }
    end

    describe 'on multios' do
      let(:input) { { os: ['linux', 'osx'], osx_image: 'xcode8.2' } }
      it { expect(value[:osx_image]).to eq 'xcode8.2' }
      it { expect(info).to include [:info, :osx_image, :edge, given: :osx_image] }
    end
  end

  describe 'when given via matrix include' do
    let(:input) { { matrix: { include: [os: 'osx', osx_image: 'xcode8.2'] } } }
    it { expect(value[:matrix][:include][0][:osx_image]).to eq 'xcode8.2' }
  end
end
