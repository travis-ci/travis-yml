# Deploy Deis



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  controller: string
  username: 
  password: 
  app: string
  cli_version: string
```

```yaml
deploy: deis

```
