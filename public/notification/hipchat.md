# Hipchat



## Type

Any of:

* Map (Hash)
* 

## Flags

None.


## Examples

```yaml
hipchat:
  rooms: "[ref:secures]"
  format: html
  notify: true
  on_pull_requests: true
  template: 
  enabled: true
  on_success: "[ref:type/notification_frequency]"
  on_failure: "[ref:type/notification_frequency]"
```

```yaml
hipchat: "[ref:secures]"

```
