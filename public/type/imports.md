# Imports



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
import:
- source: string
  mode: merge
```

```yaml
import:
- string one
- string two
```

```yaml
import:
  source: string
  mode: merge
```

```yaml
import: string

```
