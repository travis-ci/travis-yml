# Lambda



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: lambda
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  access_key_id: 
  secret_access_key: 
  region: string
  function_name: string
  role: string
  handler_name: string
  module_name: string
  zip: string
  description: string
  timeout: string
  memory_size: string
  runtime: string
  environment_variables: 
  security_group_ids: "[ref:strs]"
  subnet_ids: "[ref:strs]"
  dead_letter_config: string
  kms_key_arn: string
  tracing_mode: Active
  publish: true
  function_tags:
```

```yaml
deploy: lambda

```
