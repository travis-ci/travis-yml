# Env



## Type

Any of:

* Map (Hash)
* Any of:

* Sequence (Array)
* Any of:

* Map (Hash)
* Map (Hash)
* String

## Flags

* Expand: This is a [matrix expansion key](/matrix_expansion).


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
