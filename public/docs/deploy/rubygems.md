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
  gem: string
  file: string
  gemspec: string
  api_key:
```

```yaml
deploy: rubygems

```
