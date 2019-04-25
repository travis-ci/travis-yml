# Deploy Openshift



## Types

* Hash
* String (known)

## Values

* `openshift`


## Examples

```yaml
deploy:
  provider: openshift
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  user: 
  password: 
  deployment_branch: string
```

```yaml
deploy:
  provider: openshift
  domain: {}
```

```yaml
deploy:
  provider: openshift
  domain: string
```

```yaml
deploy:
  provider: openshift
  app: {}
```

```yaml
deploy:
  provider: openshift
  app: string
```

```yaml
deploy: openshift

```
