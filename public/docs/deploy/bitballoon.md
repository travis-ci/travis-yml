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
  access_token: 
  site_id: string
  local_dir: string
```

```yaml
deploy: bitballoon

```
