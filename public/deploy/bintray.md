# Bintray



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: bintray
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  file: string
  user: 
  key: 
  passphrase: 
  dry_run: true
```

```yaml
deploy: bintray

```
