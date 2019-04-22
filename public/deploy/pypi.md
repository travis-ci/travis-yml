# Pypi



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
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
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
