# Email



## Type

Any of:

* Map (Hash)
* 

## Flags

None.


## Examples

```yaml
email:
  recipients: "[ref:secures]"
  enabled: true
  on_success: "[ref:type/notification_frequency]"
  on_failure: "[ref:type/notification_frequency]"
```

```yaml
email: "[ref:secures]"

```
