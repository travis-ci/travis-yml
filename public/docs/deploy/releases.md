# Deploy Releases



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
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
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
