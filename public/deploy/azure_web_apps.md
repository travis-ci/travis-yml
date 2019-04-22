# Azure Web Apps



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: azure_web_apps
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  site: string
  slot: string
  username: 
  password: 
  verbose: true
```

```yaml
deploy: azure_web_apps

```
