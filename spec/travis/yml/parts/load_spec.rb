describe Travis::Yml::Parts, 'load' do
  yaml 'script: ./str'

  subject { described_class.load(parts).to_h }

  describe 'given a single string' do
    let(:parts) { yaml }
    it { should eq 'script' => './str'  }
  end

  describe 'given an array of strings' do
    let(:parts) { [yaml] }
    it { should eq 'script' => './str'  }
  end

  describe 'given an array of Parts' do
    let(:parts) { [Travis::Yml::Parts::Part.new(yaml)] }
    it { should eq 'script' => './str'  }
  end
end
