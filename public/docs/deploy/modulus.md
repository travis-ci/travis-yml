# Deploy Modulus



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: modulus
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  api_key: 
  project_name: string
```

```yaml
deploy: modulus

```
