# Deploy Script



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: script
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  script: string
```

```yaml
deploy: script

```
