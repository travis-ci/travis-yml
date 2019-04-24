# Deploy Cloud66



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  redeployment_hook: string
```

```yaml
deploy: cloud66

```
