# Stages



## Type

Any of:

* Sequence (Array)
* Any of:

* Map (Hash)
* String

## Flags

None.


## Examples

```yaml
stages:
- name: job name
  if: string
```

```yaml
stages:
- job name one
- job name two
```

```yaml
stages:
  name: job name
  if: string
```

```yaml
stages: job name

```
