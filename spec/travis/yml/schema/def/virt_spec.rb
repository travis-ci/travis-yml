describe Travis::Yml::Schema::Def::Virt do
  subject { Travis::Yml.schema[:definitions][:type][:virt] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :virt,
      title: 'Virtualization',
      summary: kind_of(String),
      type: :string,
      aliases: [
        :virtualization
      ],
      enum: [
        'lxd',
        'vm'
      ],
      downcase: true,
    )
  end
end
