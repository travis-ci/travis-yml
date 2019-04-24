# Notification Pushover



## Type

Any of:

* Map (Hash)
* Boolean

## Flags

None.


## Examples

```yaml
pushover:
  enabled: true
  api_key: "[ref:secures]"
  users: "[ref:secures]"
  template: string
  on_success: always
  on_failure: always
```

```yaml
pushover: true

```
