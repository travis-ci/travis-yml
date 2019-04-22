# Packagecloud



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: packagecloud
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  username: 
  token: 
  repository: string
  local_dir: string
  dist: string
  package_glob: string
  force: true
```

```yaml
deploy: packagecloud

```
