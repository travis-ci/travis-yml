# Notifications



## Types

* Hash
* Hash
* Array of: 
* 
* Boolean



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
  enabled: true
  on_success: always
  on_failure: always
```

```yaml
notifications:
  recipients:
  - secure: encrypted string
```

```yaml
notifications:
  recipients:
```

```yaml
notifications:
- secure: encrypted string
```

```yaml
notifications:

```

```yaml
notifications: true

```
