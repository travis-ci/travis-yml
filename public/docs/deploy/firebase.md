# Deploy Firebase



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: firebase
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  project: string
  token: 
  message: string
```

```yaml
deploy: firebase

```
