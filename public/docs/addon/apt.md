# Addon Apt



## Type

Any of:

* Map (Hash)
* 
* Boolean

## Flags

None.


## Examples

```yaml
apt:
  packages: "[ref:strs]"
  dist: string
```

```yaml
apt:
  sources:
  - name: string
```

```yaml
apt:
  sources:
    name: string
```

```yaml
apt:
  sources:
  - string one
  - string two
```

```yaml
apt:
  sources: string
```

```yaml
apt: "[ref:strs]"

```

```yaml
apt: true

```
