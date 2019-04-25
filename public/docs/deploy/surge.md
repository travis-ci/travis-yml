# Deploy Surge



## Types

* Hash
* String (known)

## Values

* `surge`


## Examples

```yaml
deploy:
  provider: surge
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  project: string
  domain: string
```

```yaml
deploy: surge

```
