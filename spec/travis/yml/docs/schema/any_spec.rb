describe Travis::Yml::Docs::Schema::Any do
  let(:root) { Travis::Yml::Docs::Schema::Factory.build(nil, Travis::Yml.schema) }

  subject { root[:import] }

  it { should be_a described_class }
  it { should have_opt id: :imports }

  describe 'expand' do
    let(:schemas) { subject.expand }

    it { expect(schemas.size).to eq 4 }
    it { expect(schemas.map(&:type)).to eq [:seq, :seq, :map, :str] }
    # it { expect(schemas[0].schema.type).to eq :map }
    # it { expect(schemas[0].schema.id).to eq :import }
  end

  # describe 'parents' do
  #   subject { root[:notifications].schemas[0].mappings[:campfire] }
  #   it { p subject.parents }
  # end
end

