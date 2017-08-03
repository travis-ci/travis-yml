describe Travis::Yaml::Spec::Def::Deploy::Lambda do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :lambda,
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
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :allow_failure, :edge)).to eq(
      access_key_id: {
        key: :access_key_id,
        types: [
          {
            type: :scalar,
            secure: true,
            required: true
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      secret_access_key: {
        key: :secret_access_key,
        types: [
          {
            type: :scalar,
            secure: true,
            required: true
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      region: {
        key: :region,
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      function_name: {
        key: :function_name,
        types: [
          {
            type: :scalar,
            required: true
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      role: {
        key: :role,
        types: [
          {
            type: :scalar,
            required: true
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      handler_name: {
        key: :handler_name,
        types: [
          {
            type: :scalar,
            required: true
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      module_name: {
        key: :module_name,
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      zip: {
        key: :zip,
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      description: {
        key: :description,
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      timeout: {
        key: :timeout,
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      memory_size: {
        key: :memory_size,
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      runtime: {
        key: :runtime,
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      environment_variables: {
        key: :environment_variables, 
        types: [
          {
            type: :scalar, 
            secure: true
          },
          {
            type: :map, 
            secure: true,
            strict: false
          },
          {
            name: :deploy_branches,
            type: :map, 
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      security_group_ids: {
        key: :security_group_ids, 
        types: [
          {
            type: :seq, 
            types: [
              {
                type: :scalar
              }
            ]
          },
          {
            name: :deploy_branches,
            type: :map, 
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      subnet_ids: {
        key: :subnet_ids, 
        types: [
          {
            type: :seq, 
            types: [
              {
                type: :scalar
              }
            ]
          },
          {
            name: :deploy_branches,
            type: :map, 
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      kms_key_arn: {
        key: :kms_key_arn, 
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map, 
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      dead_letter_config: {
        key: :dead_letter_config, 
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map, 
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      tracing_mode: {
        key: :tracing_mode, 
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map, 
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      }
    )
  end
end
