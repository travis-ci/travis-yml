# Notifications



## Type

Any of:

* Map (Hash)
* Any of:

* Map (Hash)
* 

## Flags

None.


## Examples

```yaml
notifications:
  campfire: "[ref:notification/campfire]"
  email: "[ref:notification/email]"
  flowdock: "[ref:notification/flowdock]"
  hipchat: "[ref:notification/hipchat]"
  irc: "[ref:notification/irc]"
  pushover: "[ref:notification/pushover]"
  slack: "[ref:notification/slack]"
  webhooks: "[ref:notification/webhooks]"
```

```yaml
notifications:
  recipients: "[ref:secures]"
  enabled: true
  on_success: "[ref:type/notification_frequency]"
  on_failure: "[ref:type/notification_frequency]"
```

```yaml
notifications: "[ref:secures]"

```
