describe Travis::Yml::Schema::Def::Group do
  subject { Travis::Yml.schema[:definitions][:type][:group] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :group,
      title: 'Group',
      summary: 'Build environment group',
      type: :string,
      flags: [:internal]
    )
  end
end
