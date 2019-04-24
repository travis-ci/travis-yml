# Deploy Packagecloud



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
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
