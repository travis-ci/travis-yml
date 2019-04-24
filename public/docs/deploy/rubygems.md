# Deploy Rubygems



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: rubygems
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  api_key: 
  gem: string
  file: string
  gemspec: string
```

```yaml
deploy: rubygems

```
