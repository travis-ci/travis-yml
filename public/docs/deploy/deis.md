# Deploy Deis



## Types

* Hash
* String (known)

## Values

* `deis`


## Examples

```yaml
deploy:
  provider: deis
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  controller: string
  username: 
  password: 
  app: string
  cli_version: string
```

```yaml
deploy: deis

```
