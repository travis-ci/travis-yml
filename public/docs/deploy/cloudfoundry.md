# Deploy Cloudfoundry



## Types

* Hash
* String (known)

## Values

* `cloudfoundry`


## Examples

```yaml
deploy:
  provider: cloudfoundry
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  username: 
  password: 
  organization: string
  api: string
  space: string
  key: string
  manifest: string
  skip_ssl_validation: true
```

```yaml
deploy: cloudfoundry

```
