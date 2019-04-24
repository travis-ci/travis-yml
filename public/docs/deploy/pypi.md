# Deploy Pypi



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: pypi
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  user: 
  password: 
  api_key: 
  server: string
  distributions: string
  docs_dir: string
```

```yaml
deploy: pypi

```
