# Opsworks



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: opsworks
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  access_key_id: 
  secret_access_key: 
  app_id: string
  instance_ids: string
  layer_ids: string
  migrate: true
  wait_until_deployed: string
  custom_json: string
```

```yaml
deploy: opsworks

```
