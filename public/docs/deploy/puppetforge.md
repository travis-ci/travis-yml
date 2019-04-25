# Deploy Puppetforge



## Types

* Hash
* String (known)

## Values

* `puppetforge`


## Examples

```yaml
deploy:
  provider: puppetforge
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  user: 
  password: 
  url: string
```

```yaml
deploy: puppetforge

```
