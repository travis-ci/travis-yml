describe Travis::Yml::Schema::Def::Conditions do
  describe 'conditions' do
    subject { Travis::Yml.schema[:definitions][:type][:conditions] }

    it do
      should eq(
        '$id': :conditions,
        type: :string,
        title: 'Conditions',
        summary: 'Conditions support version',
        enum: ['v0', 'v1'],
        flags: [:internal]
      )
    end
  end

  describe 'condition' do
    subject { except(Travis::Yml.schema[:definitions][:type][:condition], :description) }

    it do
      should include(
        '$id': :condition,
        type: :string,
        title: 'If',
        summary: kind_of(String),
        example: 'branch = master',
        see: kind_of(Hash)
      )
    end
  end
end
