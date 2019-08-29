describe Travis::Yml::Schema::Def::Dist do
  subject { Travis::Yml.schema[:definitions][:type][:dist] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :dist,
      title: 'Distribution',
      summary: 'Build environment distribution',
      type: :string,
      enum: [
        'trusty',
        'precise',
        'xenial',
        'bionic',
        'server-2016'
      ],
      downcase: true,
      values: {
        bionic: {
          only: {
            os: [
              'linux'
            ]
          }
        },
        trusty: {
          only: {
            os: [
              'linux'
            ]
          }
        },
        precise: {
          only: {
            os: [
              'linux'
            ]
          }
        },
        xenial: {
          only: {
            os: [
              'linux'
            ]
          }
        },
        'server-2016': {
          only: {
            os: [
              'windows'
            ]
          },
          edge: true
        },
      }
    )
  end
end
