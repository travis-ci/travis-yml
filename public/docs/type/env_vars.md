# Env Vars



## Types

* Array of: Hash
* Array of: Hash
* Array of: String
* Hash
* Hash
* String



## Examples

```yaml
env:
- secure: string
```

```yaml
env:
- "^(?!global|matrix)": string
```

```yaml
env:
- string one
- string two
```

```yaml
env:
  secure: string
```

```yaml
env:
  "^(?!global|matrix)": string
```

```yaml
env: string

```
