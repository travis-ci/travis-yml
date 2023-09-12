describe Travis::Yml::Schema::Def::Matlab do
  subject { Travis::Yml.schema[:definitions][:language][:matlab] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :matlab,
        title: 'Matlab',
        summary: kind_of(String),
        see: kind_of(Hash),
        type: :object,
        normal: true
    )
  end
end
