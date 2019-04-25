# Deploy Cloudfiles



## Types

* Hash
* String (known)

## Values

* `cloudfiles`


## Examples

```yaml
deploy:
  provider: cloudfiles
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  username: 
  api_key: 
  region: string
  container: string
  dot_match: true
```

```yaml
deploy: cloudfiles

```
