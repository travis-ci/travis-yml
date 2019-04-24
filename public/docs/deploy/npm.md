# Deploy Npm



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  email: 
  api_key:
```

```yaml
deploy: npm

```
