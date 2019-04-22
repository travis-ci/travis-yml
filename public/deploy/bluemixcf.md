# Bluemixcf



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: bluemixcf
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  username: 
  password: 
  organization: string
  api: string
  space: string
  region: string
  manifest: string
  skip_ssl_validation: true
```

```yaml
deploy: bluemixcf

```
