# IRC



## Type

Any of:

* Map (Hash)
* 
* Boolean

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
  template: string
  enabled: true
  on_success: always
  on_failure: always
```

```yaml
irc: "[ref:secures]"

```

```yaml
irc: true

```
