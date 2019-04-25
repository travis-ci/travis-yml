# Deploy Snap



## Types

* Hash
* String (known)

## Values

* `snap`


## Examples

```yaml
deploy:
  provider: snap
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  snap: string
  channel: string
  token:
```

```yaml
deploy: snap

```
