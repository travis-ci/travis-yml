# Deploy Launchpad



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
  slug: string
  oauth_token: 
  oauth_token_secret: 
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
```

```yaml
deploy: launchpad

```
