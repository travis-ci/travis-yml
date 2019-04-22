# Launchpad



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: launchpad
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  slug: string
  oauth_token: 
  oauth_token_secret:
```

```yaml
deploy: launchpad

```
