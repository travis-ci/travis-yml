# Campfire



## Type

Any of:

* Map (Hash)
* 

## Flags

None.


## Examples

```yaml
campfire:
  rooms: "[ref:secures]"
  template: 
  enabled: true
  on_success: "[ref:type/notification_frequency]"
  on_failure: "[ref:type/notification_frequency]"
```

```yaml
campfire: "[ref:secures]"

```
