describe Travis::Yml::Schema::Def::Dist do
  subject { Travis::Yml.schema[:definitions][:type][:dist] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :dist,
      title: 'Distribution',
      summary: kind_of(String),
      see: kind_of(Hash),
      type: :string,
      enum: [
        'trusty',
        'precise',
        'xenial',
        'bionic',
        'focal',
        'jammy',
        'noble',
        'server-2016',
        'rhel8'
      ],
      downcase: true,
      values: {
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
              'linux',
              'linux-ppc64le'
            ]
          }
        },
        bionic: {
          only: {
            os: [
              'linux'
            ]
          }
        },
        focal: {
          only: {
            os: [
              'linux'
            ]
          }
        },
        jammy: {
          only: {
            os: [
              'linux'
            ]
          }
        },
        noble: {
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
        rhel8: {
          only: {
            os: [
              'linux'
            ]
          }
        },
      }
    )
  end
end
