This is meant as a replacement for [travis-yaml](https://github.com/travis-ci/travis-yaml).

# Travis CI build config processing

This library is used for parsing, normalizing, and validating Travis CI build
configuration (`.travis.yml`).

It has three main functions:

* Defining and producing a spec for build configuration.
* Applying the spec to an actual configuration in order to normalize and validate it.
* Expanding a build config to job matrix configs.

The library produces a specification that is used internally, but also can be
served on the API in order to be consumed by, for example:

* The UI build process (stop duplicating "expand keys").
* A `travis.yml` wizard that fully conforms the specification.

Applying the specification to a build configuration produces messages on the
levels `info`, `warn`, and `error`. Messages include a message code, e.g.
`unknown_key`, `unsupported` etc., and a human readable message. These can be
used in the UI, and links to the documentation, suggesting fixes.

# YAML

Diverging from the YAML specification this library does not:

* convert numbers to integer or float types
* convert the strings `"yes"` or `"on"` to the boolean `true`
* convert the strings `"no"` or `"off"` to the boolean `false`

For these reasons:

* Version numbers like `1.10` used to be truncated to `1.1` by the YAML parser,
  causing confusion, and requiring users to specify these as strings (`"1.10"`)
  instead.
* Deployment config uses the key `on`. This being converted to `true` as a hash
  key does not make sense for us.
* Integers add an unnecessary type to the system. Build config values that
  could be given as integers are going to be passed through the Bash build
  script. Bash does not distinguish integers from strings.

# Types

Borrowing from YAML's terminology the library uses:

* `Map` for hashes (key value mappings)
* `Seq` for arrays (sequence)
* `Scalar` for all other types (bool, string, secure string)

Also, a `Fixed` type is a `Scalar` that has a number of known and allowed
values. Examples for keys that hold fixed types are: `language`, `os`, `dist`
etc.

A `Map` can be strict or not strict. Maps are strict by default. A strict map
disallows keys that are not known.

# Build config specification

The spec is defined in `Spec::Def`, and can be produced by:

```ruby
Travis::Yaml.spec
```

Classes in `Spec::Def` use types in `Spec::Type` to build a tree of nodes that
define allowed keys, types, and various options in a readable and succinct way.

This tree is then serialized to a lengthy Hash which serves as a specification,
and both an internal and, optionally, external API.

A good starting point for exploring the definition is the [root node](/blob/master/lib/travis/yaml/spec/def/root.rb).

Examples for various nodes on this specification can be found in the tests, e.g.
for the [git](/blob/master/spec/travis/yaml/spec/def/git_spec.rb),
[heroku](/blob/master/spec/travis/yaml/spec/def/deploy/heroku_spec.rb), or
[os](/blob/master/spec/travis/yaml/spec/def/os_spec.rb) nodes.

Most nodes can be sufficiently specified by mapping known keys (e.g.
`language`) to types (`fixed`, `scalar`, `map`, `seq`) with certain options.

* `values`: known values on a `scalar` type
* `default`: default value
* `required`: the node has to have a value
* `cast`: try casting the node value to another type
* `edge`: the node represents an experimental feature
* `flagged`: the node represents a feature that requires a feature flag
* `only`: the node is valid only if the given value matches the current `language` or `os`
* `except`: the node is valid only if the given value does not match the current `language` or `os`
* `expand`: the node represents a matrix key for matrix expansion

# Applying the spec to a build config

The spec can be applied to a build configuration by:

```ruby
# given a yaml string
Travis::Yaml.load(yaml)

# given a hash
Travis::Yaml.apply(config)
```

Both methods also accept an optional options hash. There is one known option:

```ruby
Travis::Yaml.apply(yaml, alert: true)
```

The option `alert` rejects plain strings and adds an error message on nodes
that expect a secure string.

Applying the spec to a build configuration uses the `Doc::Factory::Node`, which
uses `Doc::Factory::Map` and `Doc::Factory::Seq` in order to build a tree of
nodes that maps to the given build config hash and selects nodes from the spec.

Before the node type is determined, and a node created, the factory normalizes
the given value. Amongst other things normalization does for example:

* symbolize hash keys
* turn secure strings into instances of `Doc::Type::Secure`
* apply prefixes as defined by the spec
* apply custom normalizations as defined by the spec (e.g.
  [enabled](/blob/master/spec/travis/yaml/doc/normalize/enabled.rb) for addon
  nodes

After normalizing the given config value the factory creates the node, and
adds children for hashes (map) and arrays (seq).

Once this tree of nodes is produced `Doc::Conform.apply` is applied. This will
run various validations and transformations (conformers) on each node of the
tree in 3 stages, depending on the type of the node.

Conformers are mapped to stages and node types [here](/blob/master/spec/travis/yaml/doc/conform.rb#L25).

Meaning of the conformers:

* `alert`: unset the value and add an `error` level message if the given value is a string while a secure string is expected
* `alias`: use the other value and add an `info` level message if the given value is an alias for another value
* `cast`: try casting the value to another type if required by the spec (e.g. the string `"true"` to the boolean `true`)
* `default`: use a default value as required by the spec if the node does not have a value
* `downcase`: downcase a string if required by the spec
* `edge`: add an `info` level message if this node type is used (experimental features)
* `empty`: drop an empty section
* `flagged`: add an `info` level message if this node type is used (features that require a feature flag)
* `format`: unset the value and add an `error` level message if the given value does not conform with the format as required by the spec
* `incompatible`: unset the value and add an `error` level message if the given fixed value is not compatible with the current language or os, as defined by the spec
* `invalid_type`: unset the value if the given value's type is not compatible with the node type
* `matrix`: unset the value and add an `error` level message if the given key on `matrix.include`, `matrix.exclude` or `matrix.allow_failures` is not compatible with the current language or os, as defined by the spec
* `pick`: pick the first value of a given sequence for a scalar node and add an `info` level message
* `required`: drop an empty node and add an `error` level message if the node is required by the spec
* `template`: drop the value and add an `error` level message if the given template string uses unknown variables
* `unknown_keys`: drop unknown keys from a strict map and add `error` level messages for them
* `unknown_value`: drop unknown values from a fixed type
* `unsupported`: unset the value and add an `error` level message if the given key is not compatible with the current language or os, as defined by the spec

# Expanding a build matrix

A given build configuration can be expanded to job matrix configurations by:

```ruby
Travis::Yaml.matrix(config)
```

E.g. a build config like:

```ruby
{
  language: 'ruby',
  ruby: ['2.2', '2.3'],
  env: ['FOO=foo', 'BAR=bar']
}
```

will be expanded to:

```ruby
[
  { language: 'ruby', ruby: '2.2', env: 'FOO=foo' },
  { language: 'ruby', ruby: '2.2', env: 'BAR=bar' },
  { language: 'ruby', ruby: '2.3', env: 'FOO=foo' },
  { language: 'ruby', ruby: '2.3', env: 'BAR=bar' },
]
```

