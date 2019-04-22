# Scalingo



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: scalingo
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  username: 
  password: 
  api_key: 
  remote: string
  branch: string
  app: string
```

```yaml
deploy: scalingo

```
