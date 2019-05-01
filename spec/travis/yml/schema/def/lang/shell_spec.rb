describe Travis::Yml::Schema::Def::Shell, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:shell] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_shell,
        title: 'Language Shell',
        type: :object,
        normal: true
    )
  end
end
