# Cloudcontrol



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: cloudcontrol
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  email: 
  password: 
  deployment: string
```

```yaml
deploy: cloudcontrol

```
