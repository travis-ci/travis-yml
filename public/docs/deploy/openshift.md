# Deploy Openshift



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


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
  domain: string
  app: string
  deployment_branch: string
```

```yaml
deploy: openshift

```
