# Deploy Boxfuse



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
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
