# Deploy Atlas



## Types

* Hash
* String (known)

## Values

* `atlas`


## Examples

```yaml
deploy:
  provider: atlas
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  token: 
  app: string
  exclude: string
  include: string
  address: string
  metadata: string
  debug: true
  vcs: true
  version: true
```

```yaml
deploy: atlas

```
