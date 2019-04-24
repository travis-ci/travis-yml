# Deploy Catalyze



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: catalyze
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  target: string
  path: string
```

```yaml
deploy: catalyze

```
