# Deploy Appfog



## Types

* Hash
* String (known)

## Values

* `appfog`


## Examples

```yaml
deploy:
  provider: appfog
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  user: 
  api_key: 
  address: string
  metadata: string
  after_deploy: string
```

```yaml
deploy:
  provider: appfog
  app: {}
```

```yaml
deploy:
  provider: appfog
  app: string
```

```yaml
deploy:
  provider: appfog
  email:
    ".*":
```

```yaml
deploy:
  provider: appfog
  email:
```

```yaml
deploy:
  provider: appfog
  password:
    ".*":
```

```yaml
deploy:
  provider: appfog
  password:
```

```yaml
deploy: appfog

```
