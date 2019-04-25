# Deploy Rubygems



## Types

* Hash
* String (known)

## Values

* `rubygems`


## Examples

```yaml
deploy:
  provider: rubygems
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  file: string
  gemspec: string
```

```yaml
deploy:
  provider: rubygems
  api_key: {}
```

```yaml
deploy:
  provider: rubygems
  api_key:
```

```yaml
deploy:
  provider: rubygems
  gem: {}
```

```yaml
deploy:
  provider: rubygems
  gem: string
```

```yaml
deploy: rubygems

```
