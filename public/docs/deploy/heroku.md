# Deploy Heroku



## Types

* Hash
* String (known)

## Values

* `heroku`


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
  run: string
```

```yaml
deploy:
  provider: heroku
  app: {}
```

```yaml
deploy:
  provider: heroku
  app: string
```

```yaml
deploy:
  provider: heroku
  api_key: {}
```

```yaml
deploy:
  provider: heroku
  api_key:
```

```yaml
deploy: heroku

```
