describe Travis::Yml::Schema::Def::Conditions, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:type][:conditions] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :conditions,
        title: 'Conditions',
        type: :string,
        enum: ['v0', 'v1'],
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/conditions'
      )
    end
  end
end
