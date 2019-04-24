# Deploy Cargo



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: cargo
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  token:
```

```yaml
deploy: cargo

```
