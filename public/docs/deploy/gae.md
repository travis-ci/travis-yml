# Deploy Gae



## Types

* Hash
* String (known)

## Values

* `gae`


## Examples

```yaml
deploy:
  provider: gae
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  project: string
  keyfile: string
  config: string
  version: string
  no_promote: true
  no_stop_previous_version: true
  verbosity: string
```

```yaml
deploy: gae

```
