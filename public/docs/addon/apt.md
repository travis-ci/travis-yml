# Addon Apt



## Types

* Hash
* Array of: String
* String
* Boolean



## Examples

```yaml
apt:
  packages: string
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
apt:
- string one
- string two
```

```yaml
apt: string

```

```yaml
apt: true

```
