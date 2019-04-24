# Notification Email



## Type

Any of:

* Map (Hash)
* 
* Boolean

## Flags

None.


## Examples

```yaml
email:
  recipients: "[ref:secures]"
  enabled: true
  on_success: always
  on_failure: always
```

```yaml
email: "[ref:secures]"

```

```yaml
email: true

```
