# Deploy Boxfuse



## Types

* Hash
* String (known)

## Values

* `boxfuse`


## Examples

```yaml
deploy:
  provider: boxfuse
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  user: 
  secret: 
  configfile: string
  payload: string
  app: string
  version: string
  env: string
  image: string
  extra_args: string
```

```yaml
deploy: boxfuse

```
