# Deploy Snap



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


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
