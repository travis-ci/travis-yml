# Deploy Bitballoon



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: bitballoon
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  access-token: 
  site-id: 
  local-dir: string
```

```yaml
deploy: bitballoon

```
