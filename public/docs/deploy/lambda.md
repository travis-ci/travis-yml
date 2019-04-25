# Deploy Lambda



## Types

* Hash
* String (known)

## Values

* `lambda`


## Examples

```yaml
deploy:
  provider: lambda
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
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
  security_group_ids: string
  subnet_ids: string
  dead_letter_config: string
  kms_key_arn: string
  tracing_mode: Active
  publish: true
  function_tags:
```

```yaml
deploy: lambda

```
