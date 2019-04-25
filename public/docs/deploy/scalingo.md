# Deploy Scalingo



## Types

* Hash
* String (known)

## Values

* `scalingo`


## Examples

```yaml
deploy:
  provider: scalingo
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  username: 
  password: 
  api_key: 
  remote: string
  branch: string
  app: string
```

```yaml
deploy: scalingo

```
