describe Travis::Yml::Schema::Def::VM do
  subject { Travis::Yml.schema[:definitions][:type][:vm] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :vm,
      title: 'Vm',
      summary: kind_of(String),
      description: kind_of(String),
      see: kind_of(Hash),
      type: :object,
      properties: {
        size: {
          type: :string,
          enum: [
            'medium',
            'large',
            'x-large',
            '2x-large'
          ]
        },
      },
      additionalProperties: false
    )
  end
end
