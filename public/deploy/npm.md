# Npm



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: npm
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  email: 
  api_key:
```

```yaml
deploy: npm

```
