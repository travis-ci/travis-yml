# Gae



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: gae
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  project: string
  keyfile: string
  config: string
  version: string
  no_promote: true
  no_stop_previous_version: true
  verbosity: string
```

```yaml
deploy: gae

```
