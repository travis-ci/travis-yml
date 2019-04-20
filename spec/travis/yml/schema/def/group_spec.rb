describe Travis::Yml::Schema::Def::Group, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:type][:group] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :group,
        title: 'Group',
        type: :string,
        downcase: true
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/type/group'
  #     )
  #   end
  # end
end
