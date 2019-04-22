# Rubygems



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
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  gem: string
  file: string
  gemspec: string
  api_key:
```

```yaml
deploy: rubygems

```
