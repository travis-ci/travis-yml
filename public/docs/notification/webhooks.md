# Notification Webhooks



## Type

Any of:

* Map (Hash)
* 
* Boolean

## Flags

None.


## Examples

```yaml
webhooks:
  urls: "[ref:secures]"
  on_start: always
  on_cancel: always
  on_error: always
  enabled: true
  on_success: always
  on_failure: always
```

```yaml
webhooks: "[ref:secures]"

```

```yaml
webhooks: true

```
