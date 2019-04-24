# Deploy Gcs



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: gcs
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  access_key_id: 
  secret_access_key: 
  bucket: string
  upload_dir: string
  local_dir: string
  dot_match: true
  acl: string
  cache_control: string
  detect_encoding: true
```

```yaml
deploy: gcs

```
