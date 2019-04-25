# Deploy Releases



## Types

* Hash
* String (known)

## Values

* `releases`


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
  file: string
  file_glob: true
  overwrite: true
  release_number: string
  prerelease: true
```

```yaml
deploy: releases

```
