describe Travis::Yml::Schema::Def::C do
  subject { Travis::Yml.schema[:definitions][:language][:c] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :c,
        title: 'C',
        type: :object,
        normal: true
    )
  end
end
