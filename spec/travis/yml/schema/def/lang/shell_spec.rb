describe Travis::Yml::Schema::Def::Shell do
  subject { Travis::Yml.schema[:definitions][:language][:shell] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :shell,
        title: 'Shell',
        type: :object,
        normal: true
    )
  end
end
