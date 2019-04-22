# Heroku



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: heroku
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  strategy: api
  buildpack: string
  app: "[ref:type/app]"
  api_key: 
  run: "[ref:strs]"
```

```yaml
deploy: heroku

```
