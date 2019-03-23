describe Travis::Yaml::Doc::Change::Cast do
  let(:lang) { subject.raw[:language] }
  let(:sudo) { subject.raw[:sudo] }

  subject { change(build(nil, :root, value, {})) }

  describe 'wanting a string' do
    describe 'given a string' do
      let(:value) { { language: 'ruby' } }
      it { expect(lang).to eq 'ruby' }
      it { expect(info).to be_empty }
    end

    describe 'given a bool' do
      let(:value) { { language: true } }
      it { expect(lang).to eq 'true' }
      it { expect(info).to be_empty }
    end

    describe 'given a map' do
      let(:value) { { language: { foo: :foo } } }
      it { expect(lang).to eq foo: :foo }
      it { expect(info).to be_empty }
    end
  end

  describe 'wanting a bool' do
    describe 'given an unkonwn string' do
      let(:value) { { sudo: 'ruby' } }
      it { expect(sudo).to eq true }
      it { expect(info).to include [:info, :sudo, :cast, given_value: 'ruby', given_type: :str, value: true, type: :bool] }
    end

    describe 'given a konwn string' do
      let(:value) { { sudo: 'not required' } }
      it { expect(sudo).to be false }
      it { expect(info).to include [:info, :sudo, :cast, given_value: 'not required', given_type: :str, value: false, type: :bool] }
    end

    describe 'given a bool' do
      let(:value) { { sudo: true } }
      it { expect(sudo).to eq true }
      it { expect(info).to be_empty }
    end

    describe 'given a map' do
      let(:value) { { sudo: { foo: :foo } } }
      it { expect(sudo).to eq foo: :foo }
      it { expect(info).to be_empty }
    end
  end
end
