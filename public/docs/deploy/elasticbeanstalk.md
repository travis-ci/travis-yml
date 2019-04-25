# Deploy Elasticbeanstalk



## Types

* Hash
* String (known)

## Values

* `elasticbeanstalk`


## Examples

```yaml
deploy:
  provider: elasticbeanstalk
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  access_key_id: 
  securet_access_key: 
  region: string
  app: string
  env: string
  zip_file: string
  bucket_name: string
  bucket_path: string
  only_create_app_version: true
```

```yaml
deploy: elasticbeanstalk

```
