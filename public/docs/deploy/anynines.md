# Deploy Anynines



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: anynines
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  username: 
  password: 
  organization: string
  space: string
```

```yaml
deploy: anynines

```
