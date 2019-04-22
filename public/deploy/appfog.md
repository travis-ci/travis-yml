# Appfog



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: appfog
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  user: 
  api_key: 
  address: "[ref:strs]"
  metadata: string
  after_deploy: "[ref:strs]"
  app: "[ref:type/app]"
  email: 
  password:
```

```yaml
deploy: appfog

```
