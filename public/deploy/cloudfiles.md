# Cloudfiles



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: cloudfiles
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  username: 
  api_key: 
  region: string
  container: string
  dot_match: true
```

```yaml
deploy: cloudfiles

```
