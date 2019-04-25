# Env



## Types

* Hash
* Array of: Hash
* Array of: Hash
* Array of: String
* Hash
* Hash
* String


## Flags


* expand

## Examples

```yaml
env:
  global: string
  matrix: string
```

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
