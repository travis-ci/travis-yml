# Deploy Bintray



## Types

* Hash
* String (known)

## Values

* `bintray`


## Examples

```yaml
deploy:
  provider: bintray
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  file: string
  user: 
  key: 
  passphrase: 
  dry_run: true
```

```yaml
deploy: bintray

```
