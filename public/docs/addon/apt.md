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
  update: true
```

```yaml
apt:
  sources:
  - name: string
    sourceline: string
    key_url: string
```

```yaml
apt:
  sources:
    name: string
    sourceline: string
    key_url: string
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
