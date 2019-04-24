# Notification Campfire



## Type

Any of:

* Map (Hash)
* 
* Boolean

## Flags

None.


## Examples

```yaml
campfire:
  rooms: "[ref:secures]"
  template: string
  enabled: true
  on_success: always
  on_failure: always
```

```yaml
campfire: "[ref:secures]"

```

```yaml
campfire: true

```
