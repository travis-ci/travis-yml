describe Travis::Yaml::Spec::Def::Deploy::Lambda do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :lambda,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: :scalar
      }
    )
  end

  it do
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :edge)).to eq(
      access_key_id: {
        key: :access_key_id,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            required: true
          }
        ]
      },
      secret_access_key: {
        key: :secret_access_key,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            required: true
          }
        ]
      },
      region: {
        key: :region,
        types: [
          {
            type: :scalar
          }
        ]
      },
      function_name: {
        key: :function_name,
        types: [
          {
            type: :scalar,
            required: true
          }
        ]
      },
      role: {
        key: :role,
        types: [
          {
            type: :scalar,
            required: true
          }
        ]
      },
      handler_name: {
        key: :handler_name,
        types: [
          {
            type: :scalar,
            required: true
          }
        ]
      },
      module_name: {
        key: :module_name,
        types: [
          {
            type: :scalar
          }
        ]
      },
      zip: {
        key: :zip,
        types: [
          {
            type: :scalar
          }
        ]
      },
      description: {
        key: :description,
        types: [
          {
            type: :scalar
          }
        ]
      },
      timeout: {
        key: :timeout,
        types: [
          {
            type: :scalar
          }
        ]
      },
      memory_size: {
        key: :memory_size,
        types: [
          {
            type: :scalar
          }
        ]
      },
      runtime: {
        key: :runtime,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
