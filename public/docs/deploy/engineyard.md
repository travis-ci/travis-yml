# Deploy Engineyard



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
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
