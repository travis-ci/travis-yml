# Cloudfoundry



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: cloudfoundry
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  username: 
  password: 
  organization: string
  api: string
  space: string
  key: string
  manifest: string
  skip_ssl_validation: true
```

```yaml
deploy: cloudfoundry

```
