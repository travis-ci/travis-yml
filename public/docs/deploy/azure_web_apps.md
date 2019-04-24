# Deploy Azure Web Apps



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  site: string
  slot: string
  username: 
  password: 
  verbose: true
```

```yaml
deploy: azure_web_apps

```
