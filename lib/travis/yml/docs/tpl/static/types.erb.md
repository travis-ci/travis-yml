# Types

The type names chosen in the Travis CI build configuration specification are
borrowed from both YAML and JSON Schema.

However, they add additional meaning in that complex types allow accepting
simpler types by applying normalization through well-known patterns.

## Sequence

An ordered sequence (an array, a list) of elements that allows duplicates.

For example:

```yaml
env:
- FOO=foo
- BAR=bar
```

```yaml
import:
- ./one.yml@v1
- ./two.yml@v1
```

Sequences of a given type always also accept the type itself, and normalize
it by wrapping into a sequence.

For example:

```yaml
os: linux
```

Because the `os` node expects a sequence of strings this will be normalized to:

```yaml
os:
- linux
```

## Map

A map (a hash, a dictionary) of key/value pairs.

For example:

```yaml
env:
  FOO: foo
  BAR: bar
```

```yaml
import:
  source: ./one.yml@v1
  mode: deep_merge
```

Many map nodes define a default prefix key, which allows the node to accept the
type that the prefix key maps to.

For example the [Branches](<%= path_to('nodes/branches') %>) node expects a
map, and defines the key `only` to be the default prefix key, which expects a
sequence of strings.

Therefor:

```yaml
branches:
- master
```

This will be normalized to:

```yaml
branches:
  only:
  - master
```

Together with the normalization [sequences](#sequence) apply:

```yaml
branches: master
```

This will be normalized to the same normal form:

```yaml
branches:
  only:
  - master
```

## Enum

A scalar (string, number, or boolean) allowing one out of several known values.

For example, the key `dist` accepts any of the following values:
<%= Yml.schema[:definitions][:type][:dist][:enum].map { |str| "`#{str}`" }.join(', ') %>.
