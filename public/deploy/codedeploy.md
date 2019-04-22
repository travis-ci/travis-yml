# Codedeploy



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: codedeploy
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  access_key_id: 
  secret_access_key: 
  application: string
  deployment_group: string
  revision_type: s3
  commit_id: string
  repository: string
  region: string
  wait_until_deployed: true
  bucket: string
  key: string
```

```yaml
deploy: codedeploy

```
