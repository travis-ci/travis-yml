# Deploy Hackage



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: hackage
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  username: 
  password:
```

```yaml
deploy: hackage

```
