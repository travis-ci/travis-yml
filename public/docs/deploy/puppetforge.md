# Deploy Puppetforge



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: puppetforge
  user: 
  password: 
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  url: string
```

```yaml
deploy: puppetforge

```
