# Cloud66



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: cloud66
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  redeployment_hook: string
```

```yaml
deploy: cloud66

```
