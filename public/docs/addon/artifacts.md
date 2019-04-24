# Addon Artifacts



## Type

Any of:

* Map (Hash)
* Boolean

## Flags

None.


## Examples

```yaml
artifacts:
  enabled: true
  bucket: string
  endpoint: string
  key: 
  secret: 
  paths: "[ref:strs]"
  branch: string
  log_format: string
  target_paths: "[ref:strs]"
  debug: true
  concurrency: 1
  max_size: 1
  region: string
  permissions: string
  working_dir: string
  cache_control: string
```

```yaml
artifacts: true

```
