# Env Vars



## Type

Any of:

* Sequence (Array)
* Any of:

* Map (Hash)
* Map (Hash)
* String

## Flags

None.


## Examples

```yaml
matrix:
- secure: string
```

```yaml
matrix:
- "^(?!global|matrix)": string
```

```yaml
matrix:
- string one
- string two
```

```yaml
matrix:
  secure: string
```

```yaml
matrix:
  "^(?!global|matrix)": string
```

```yaml
matrix: string

```
