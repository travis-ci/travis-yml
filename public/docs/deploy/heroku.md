# Deploy Heroku



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  strategy: api
  buildpack: string
  app: string
  api_key: 
  run: "[ref:strs]"
```

```yaml
deploy: heroku

```
