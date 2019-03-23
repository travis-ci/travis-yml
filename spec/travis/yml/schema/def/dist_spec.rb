describe Travis::Yml::Schema::Def::Dist, 'structure' do
  describe 'definitions' do
    describe 'dist' do
      subject { Travis::Yml.schema[:definitions][:type][:dist] }

      # it { puts JSON.pretty_generate(subject) }

      it do
        should eq(
          '$id': :dist,
          title: 'Dist',
          type: :string,
          enum: [
            'trusty',
            'precise',
            'xenial',
            'server-2016'
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
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/dist'
      )
    end
  end
end
