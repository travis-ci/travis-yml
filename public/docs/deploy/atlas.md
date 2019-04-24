# Deploy Atlas



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


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
  exclude: "[ref:strs]"
  include: "[ref:strs]"
  address: string
  vcs: true
  metadata: "[ref:strs]"
  debug: true
  version: string
```

```yaml
deploy: atlas

```
