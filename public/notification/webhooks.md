# Webhooks



## Type

Any of:

* Map (Hash)
* 

## Flags

None.


## Examples

```yaml
webhooks:
  urls: "[ref:secures]"
  on_start: "[ref:type/notification_frequency]"
  enabled: true
  on_success: "[ref:type/notification_frequency]"
  on_failure: "[ref:type/notification_frequency]"
```

```yaml
webhooks: "[ref:secures]"

```
