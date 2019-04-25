# Deploy Bluemixcloudfoundry



## Types

* Hash
* String (known)

## Values

* `bluemixcloudfoundry`


## Examples

```yaml
deploy:
  provider: bluemixcloudfoundry
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  username: 
  password: 
  organization: string
  api: string
  space: string
  region: string
  manifest: string
  skip_ssl_validation: true
```

```yaml
deploy: bluemixcloudfoundry

```
