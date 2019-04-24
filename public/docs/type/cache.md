# Cache



## Type

Any of:

* Map (Hash)
* 

## Flags

None.


## Examples

```yaml
cache:
  apt: true
  bundler: true
  cargo: true
  ccache: true
  cocoapods: true
  npm: true
  packages: true
  pip: true
  yarn: true
  edge: true
  directories: "[ref:strs]"
  timeout: 1
  branch: string
```

```yaml
cache: "[ref:strs]"

```
