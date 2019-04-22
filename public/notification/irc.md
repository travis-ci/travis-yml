# IRC



## Type

Any of:

* Map (Hash)
* 

## Flags

None.


## Examples

```yaml
irc:
  channels: "[ref:secures]"
  channel_key: 
  password: 
  nickserv_password: 
  nick: 
  use_notice: true
  skip_join: true
  template: 
  enabled: true
  on_success: "[ref:type/notification_frequency]"
  on_failure: "[ref:type/notification_frequency]"
```

```yaml
irc: "[ref:secures]"

```
