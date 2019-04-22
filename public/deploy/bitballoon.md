# Bitballoon



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
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  access_token: 
  site_id: string
  local_dir: string
```

```yaml
deploy: bitballoon

```
