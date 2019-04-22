# Releases



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: releases
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  user: 
  password: 
  api_key: 
  repo: string
  file: "[ref:strs]"
  file_glob: string
  overwrite: string
  release_number: string
  prerelease: true
```

```yaml
deploy: releases

```
