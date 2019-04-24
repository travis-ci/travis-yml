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
