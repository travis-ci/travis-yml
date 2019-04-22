# Boxfuse



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: boxfuse
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  user: 
  secret: 
  configfile: string
  payload: string
  app: string
  version: string
  env: string
  image: string
  extra_args: string
```

```yaml
deploy: boxfuse

```
