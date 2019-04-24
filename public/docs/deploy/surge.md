# Deploy Surge



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: surge
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  project: string
  domain: string
```

```yaml
deploy: surge

```
