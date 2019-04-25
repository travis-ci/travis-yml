# Deploy Codedeploy



## Types

* Hash
* String (known)

## Values

* `codedeploy`


## Examples

```yaml
deploy:
  provider: codedeploy
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
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
