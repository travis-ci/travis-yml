# Engineyard



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: engineyard
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  username: 
  password: 
  api_key: 
  app: string
  environment: string
  migrate: string
```

```yaml
deploy: engineyard

```
