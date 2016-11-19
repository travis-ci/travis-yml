describe Travis::Yaml::Spec::Def::Jdks do
  subject { described_class.new }

  let(:spec)  { subject.spec }

  it { expect(spec.keys).to     eq [:name, :type, :except, :types] }
  it { expect(spec[:name]).to   eq :jdks }
  it { expect(spec[:type]).to   eq :seq }
  it { expect(spec[:types]).to  eq [name: :jdk, type: :scalar] }
  it { expect(spec[:except]).to eq(os: ['osx']) }
end
