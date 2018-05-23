describe Travis::Yaml::Spec::Def::Deploy::Deploy do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :deploy,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: [:str]
      },
      types: [
        {
          name: :deploy_branches,
          type: :map,
          strict: false,
          deprecated: :branch_specific_option_hash
        }
      ]
    )
  end

  it do
    # TODO on is huge (has all the language specific stuff)
    expect(except(spec[:map], :on)).to eq(
      provider: {
        key: :provider,
        types: [
          name: :provider,
          type: :fixed,
          required: true,
          values: [
            {
              value: 'deploy'
            },
            {
              value: 'anynines'
            },
            {
              value: 'appfog'
            },
            {
              value: 'atlas'
            },
            {
              value: 'azure_web_apps'
            },
            {
              value: 'bintray'
            },
            {
              value: 'bitballoon'
            },
            {
              value: 'bluemixcf'
            },
            {
              value: 'boxfuse'
            },
            {
              value: 'catalyze'
            },
            {
              value: 'chef_supermarket'
            },
            {
              value: 'cloud66'
            },
            {
              value: 'cloudcontrol'
            },
            {
              value: 'cloudfiles'
            },
            {
              value: 'cloudfoundry'
            },
            {
              value: 'codedeploy'
            },
            {
              value: 'deis'
            },
            {
              value: 'divshot'
            },
            {
              value: 'elasticbeanstalk'
            },
            {
              value: 'engineyard'
            },
            {
              value: 'exoscale'
            },
            {
              value: 'firebase'
            },
            {
              value: 'gae'
            },
            {
              value: 'gcs'
            },
            {
              value: 'hackage'
            },
            {
              value: 'heroku'
            },
            {
              value: 'lambda'
            },
            {
              value: 'launchpad'
            },
            {
              value: 'modulus'
            },
            {
              value: 'nodejitsu'
            },
            {
              value: 'npm'
            },
            {
              value: 'openshift'
            },
            {
              value: 'opsworks'
            },
            {
              value: 'packagecloud'
            },
            {
              value: 'pages'
            },
            {
              value: 'puppetforge'
            },
            {
              value: 'pypi'
            },
            {
              value: 'releases'
            },
            {
              value: 'rubygems'
            },
            {
              value: 's3'
            },
            {
              value: 'scalingo'
            },
            {
              value: 'script'
            },
            {
              value: 'surge'
            },
            {
              value: 'testfairy'
            },
          ]
        ]
      },
      skip_cleanup: {
        key: :skip_cleanup,
        types: [
          type: :scalar,
          cast: :bool
        ]
      },
      allow_failure: {
        key: :allow_failure,
        types: [
          type: :scalar,
          cast: :bool
        ]
      },
      edge: {
        key: :edge,
        types: [
          {
            name: :deploy_edge,
            type: :map,
            edge: true,
            map: {
              source: {
                key: :source,
                types: [
                  type: :scalar
                ]
              },
              branch: {
                key: :branch,
                types: [
                  type: :scalar
                ]
              }
            },
          },
          {
            type: :scalar,
            edge: true,
            cast: :bool,
          }
        ]
      }
    )
  end
end

