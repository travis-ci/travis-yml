describe Travis::Yml::Schema::Def::Cpp do
  subject { Travis::Yml.schema[:definitions][:language][:cpp] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :cpp,
      title: 'C++',
      summary: instance_of(String),
      see: instance_of(Hash),
      type: :object,
      normal: true
    )
  end
end
