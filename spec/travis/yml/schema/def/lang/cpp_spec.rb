describe Travis::Yml::Schema::Def::Cpp do
  subject { Travis::Yml.schema[:definitions][:language][:cpp] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :cpp,
        title: 'Cpp',
        type: :object,
        normal: true
    )
  end
end
