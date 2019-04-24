# Notification Slack



## Type

Any of:

* Map (Hash)
* 
* Boolean

## Flags

None.


## Examples

```yaml
slack:
  rooms: "[ref:secures]"
  template: string
  enabled: true
  on_success: always
  on_failure: always
  on_pull_requests: true
```

```yaml
slack: "[ref:secures]"

```

```yaml
slack: true

```
