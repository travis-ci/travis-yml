# Deis



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: deis
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  controller: string
  username: 
  password: 
  app: string
  cli_version: string
```

```yaml
deploy: deis

```
