# Deploy Divshot



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: divshot
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  api_key: 
  environment: string
```

```yaml
deploy: divshot

```
