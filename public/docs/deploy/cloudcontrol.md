# Deploy Cloudcontrol



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  email: 
  password: 
  deployment: string
```

```yaml
deploy: cloudcontrol

```
