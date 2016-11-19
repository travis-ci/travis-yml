describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'shell'  } }

  it { expect(config[:language]).to eq 'shell' }

  %w(generic bash sh).each do |name|
    describe "alias #{name}" do
      let(:lang) { name }
      it { expect(config[:language]).to eq 'shell' }
    end
  end
end
