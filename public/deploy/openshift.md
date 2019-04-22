# Openshift



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
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  user: 
  password: 
  domain: string
  app: string
  deployment_branch: string
```

```yaml
deploy: openshift

```
