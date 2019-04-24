# Notifications



## Type

Any of:

* Map (Hash)
* Any of:

* Map (Hash)
* 
* Boolean

## Flags

None.


## Examples

```yaml
notifications:
  campfire: true
  email: true
  flowdock: true
  hipchat: true
  irc: true
  pushover: true
  slack: true
  webhooks: true
  on_success: always
  on_failure: always
```

```yaml
notifications:
  recipients: "[ref:secures]"
  enabled: true
  on_success: always
  on_failure: always
```

```yaml
notifications: "[ref:secures]"

```

```yaml
notifications: true

```
