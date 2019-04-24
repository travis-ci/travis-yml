# Notification Hipchat



## Type

Any of:

* Map (Hash)
* 
* Boolean

## Flags

None.


## Examples

```yaml
hipchat:
  rooms: "[ref:secures]"
  format: html
  notify: true
  on_pull_requests: true
  template: string
  enabled: true
  on_success: always
  on_failure: always
```

```yaml
hipchat: "[ref:secures]"

```

```yaml
hipchat: true

```
