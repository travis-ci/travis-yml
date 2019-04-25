# Deploy Engineyard



## Types

* Hash
* String (known)

## Values

* `engineyard`


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
  migrate: string
```

```yaml
deploy:
  provider: engineyard
  app: {}
```

```yaml
deploy:
  provider: engineyard
  app: string
```

```yaml
deploy:
  provider: engineyard
  environment: {}
```

```yaml
deploy:
  provider: engineyard
  environment: string
```

```yaml
deploy: engineyard

```
