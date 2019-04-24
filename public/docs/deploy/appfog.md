# Deploy Appfog



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


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
  address: "[ref:strs]"
  metadata: string
  after_deploy: "[ref:strs]"
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
