# Slack



## Type

Any of:

* Map (Hash)
* 

## Flags

None.


## Examples

```yaml
slack:
  rooms: "[ref:secures]"
  template: 
  enabled: true
  on_success: "[ref:type/notification_frequency]"
  on_failure: "[ref:type/notification_frequency]"
  on_pull_requests: true
```

```yaml
slack: "[ref:secures]"

```
