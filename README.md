This is a replacement for, and rewrite of [travis-yaml](https://github.com/travis-ci/travis-yaml).

# Travis CI build config processing

This library is used for parsing, normalizing, and validating Travis CI build
configuration (`.travis.yml`).

It serves these main functions:

* Defining and producing a specification for our build configuration format in the form of JSON Schema.
* Merging actual build configuration parts (such as `.travis.yml`)
* Applying the spec to a merged build configuration in order to normalize and validate it.
* Expanding a build config to job matrix configs.
* Generating reference documentation from the spec.

The specification (schema) produced by the library is being used for both
normalizing and validating build configs, and for generating reference
documentation. I.e. these two parts of the code base are clients to the
schema.

Applying the specification to a build configuration produces structured
messages on the levels `info`, `warn`, and `error`. Such messages include a
message code (e.g.  `unknown_key`, `unsupported_value` etc.) and arguments
(e.g. the given key, value) so they can be translated to human readable
messages by clients. These can be used in the UI, and links to the
documentation, suggesting fixes.

For example:

```ruby
yaml = 'rvm: 2.3'
config = Travis::Yml.load(yaml)

config.serialize
# {
#   language: 'ruby',
#   os: ['linux'],
#   rvm: '2.3'
# }

config.msgs
# [
#   [:info, :language, :default, key: :language, default: 'ruby'],
#   [:info, :language, :default, key: :os, default: 'linux'],
# ]

config.msgs.map { |msg| Travis::Yml.msg(msg) }
# [
#   '[info] on root: missing :language, using the default: "ruby"',
#   '[info] on root: missing :os, using the default: "linux"',
# ]
```

## YAML

The library uses a custom YAML parser based on Psych, using its safe YAML
parsing features.

Diverging from the YAML specification this library does not:

* convert the strings `yes` or `on` to the boolean `true`, or the strings `no`
  or `off` to the boolean `false`
* convert YAML integers or floats to Ruby integers or floats
* convert symbol keys to symbols

For the following reasons:

* Deployment config uses the key `on`. This being converted to `true` as a hash
  key does not make sense for us.
* Version numbers like `1.10` used to be truncated to `1.1` by the YAML parser,
  causing confusion, and requiring users to specify these as strings (`"1.10"`)
  instead.
* Keys need to be strings so they can carry additional meta information (such
  as the source name of the build config, and the line number for messages).

The parser uses the classes `Key`, `Map`, and `Seq` for representing Ruby strings
that are hash keys, hashes, and arrays, in order to be able to carry additional
meta information. This is then used while merging config parts, and normalizing
and validating the resulting config.

Integers and floats are not converted by the YAML parser, but they are casted
later by the build config normalization, so they can be casted only if the
respective node wants an integer or float.

## Types

Borrowing from YAML's terminology the library uses:

* `map` for hashes (key value mappings)
* `seq` for arrays (sequence)

It also uses the following scalar types:

* `str` for strings
* `num` for numbers
* `bool` for booleans
* `secure` for secure strings

Scalars can be enums, as defined by JSON Schema, i.e. they can have a number of
known and allowed values. Examples for keys that hold enums are: `language`,
`os`, `dist` etc.

A `map` can be strict or not strict. Maps are strict by default. A strict map
disallows keys that are not known.

A `secure` resembles our build config format for encrypted key/value pairs.
Secures also can be strict or not strict, and they are strict by default. A not
strict secure would accept a plain string without producing a warning (e.g. on
keys like `username` or `email`).

## Build config specification

The spec is included to the repository as [schema.json](https://github.com/travis-ci/travis-yml/blob/master/schema.json).

The spec is defined in `Schema::Def`, and can be produced by:

```ruby
Travis::Yml.schema
```

Classes in `Schema::Def` use classes in `Schema::Type` to build a tree of nodes
that define allowed keys, types, and various options in a readable and succinct
way (using a DSL for describing the schema).

This tree is then serialized by classes in `Schema::JSON` to a lengthy Hash
which serves as a specification in the form of a JSON Schema.

A good starting point for exploring the definition is the [root node](https://github.com/travis-ci/travis-yml/blob/master/lib/travis/yml/schema/def/root.rb).

Examples for various nodes on this specification can be found in the tests, e.g.
for the [git](https://github.com/travis-ci/travis-yml/blob/master/spec/travis/yml/schema/def/git_spec.rb),
[heroku](https://github.com/travis-ci/travis-yml/blob/master/spec/travis/yml/spec/schema/deploy/heroku_spec.rb), or
[os](https://github.com/travis-ci/travis-yml/blob/master/spec/travis/yml/spec/schema/os_spec.rb) nodes.

Most nodes can be sufficiently specified by mapping known keys (e.g.
`language`) to types (`str`, `bool`, `map`, `seq` etc.) with certain options,
such as:

* `values`: known values on a scalar type
* `default`: default value
* `required`: the node has to have a value
* `edge`: the node represents an experimental feature
* `only`: the node is valid only if the given value matches the current `language` or `os`
* `except`: the node is valid only if the given value does not match the current `language` or `os`
* `expand`: the node represents a matrix key for matrix expansion

In order to keep the JSON payload reasonably small the library uses JSON
Schema's mechanism for defining and referencing shared sub schemas. All nodes
that have a registered definition class are exported as such a defined sub
schema, and then referenced on the respective nodes that use them.

## Loading the spec

Before the schema can be applied to an actual build configuration it will be
expanded (i.e. shared sections will be included to nodes that require them),
and turned into an object oriented representation, so non-parametrized methods
can be memoized for better performance.

The method `Travis::Yml.expand` returns a fully expanded, object oriented
tree.

## Applying the spec to a build config

This representation of the schema can be applied to a build configuration by:

```ruby
# given a YAML string
Travis::Yml.load(yaml)

# given a Ruby hash
Travis::Yml.apply(config)
```

Both methods also accept an optional options hash. Please see [here]()
for a list of known options.

When the schema is applied to a build configuration three things happen:

* The config is turned into an object oriented representation as well by the
  way of calling `Doc::Value.build`. This method uses classes in `Doc::Value`
  in order to build a tree of nodes that maps to the given build config hash.

* The config structure is normalized by the way of calling `Doc::Change.apply`.
  This method applies various strategies in order to attempt to fix potential
  problems with the given structure, such as typos, misplaced keys, wrong
  section types. In some cases it will store messages on the resulting tree.
  Change strategies are determined based on the type of the given node. Some
  strategies can be required by the schema for certain sections that need very
  specific normalizations, such as `cache`, `env_vars`, `enable`.

* The resulting config is validated by the way of calling `Doc::Validate.apply`.
  This method applies various validations, and sets default values. It also
  stores (most of the) messages on the resulting tree. Sections also can
  require specific validations. The only section specific validation currently
  is `template` (which validates used var names in notification templates).

Examples of type specific change strategies:

* `cast`: try casting the value to another type if required by the spec (e.g. the string `"true"` to the boolean `true`)
* `downcase`: downcase a string if required by the spec
* `keys`: add required keys, and attempt to fix an unknown key by removing special chars and finding typos (uses a dictionary, as well levenshtein and similar simple strategies)
* `prefix`: turn the given value into a hash with a prefix key (e.g. turning `env: ["FOO=bar"]` into `env: { matrix: ["FOO=foo"] }`)
* `pick`: pick the first value of a given sequence for a scalar node
* `value`: de-alias fixed node values, and try fixing typos in unknown values
* `wrap`: wrap the given node into a sequence if required by the spec (e.g. `os` needs to result in an array)

Section specific change strategies:

* `env_vars`: normalize env vars according to our build config format, parse env vars in order to validate them
* `enable`: normalize `enabled` and `disabled` values, set `enabled` if missing (used by, for example, `notifications`)
* `inherit`: inherit certain keys from the parent node if present (used by, for example, `notifications`)

          map: [
            InvalidType, UnknownKeys, UnsupportedKeys, Compact, Required,
            Empty, Flags, Condition
          ],
          seq: [
            InvalidType, Compact, Empty, Unique, Flags
          ],
          obj: [
            InvalidType, UnknownValue, UnsupportedValue, Default, Alert, Flags,
            Format, Template

Examples of the validations:

* `alert`: add an `alert` level message if a node that expects a secure string accepts a plain string
* `default`: use a default value as required by the spec if the node does not have a value
* `empty`: warn about an empty section
* `format`: unset the value and if the given value does not conform with the format as required by the spec
* `invalid_type`: unset the value if the given value's type is not compatible with the spec's node type
* `required`: add an `error` level message if the given map is missing a required key
* `template`: drop the value if the given template string uses unknown variables
* `unknown_keys`: add an `error` level message for an unknown key
* `unknown_value`: add an `error` level message for an unknown value

### Summary

There are three sets of classes that are used to build trees:

* `Travis::Yml::Spec` builds the static, unexpanded Ruby hash that can be served as JSON.
* `Travis::Yml::Doc::Spec` is used to build an object oriented tree of nodes from the expanded spec.
* `Travis::Yml::Doc::Value` is used to build an object oriented tree of nodes that represent the given build config.

Only the last one, `Doc::Value`, is re-used at runtime, i.e. only for the given
build configs we build new trees. The `Doc::Spec` representation is kept in
memory, is static, and remains unchanged.

For each build config we then apply all relevant changes (`Doc::Change`) and
all relevant validations (`Doc::Validate`) to each node.

## Expanding a build matrix

A given build configuration can be expanded to job matrix configurations by:

```ruby
Travis::Yml.matrix(config)
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

## Web API

This gem also contains a web API for parsing and expanding a build config,
which is used by travis-gatekeeper when processing a build request.

To start the server:

```
$ bundle exec rackup
```

The API contains three endpoints:

**Home**

```
$ curl -X GET /v1 | jq .
```

```json
{
  "version": "v1"
}
```

**Parse**

The body of the request should be raw YAML. The response contains parsing messages and the validated and normalised config.

```
$ curl -X POST --data-binary @travis.yml /v1/parse | jq .
```

```json
{
  "version": "v1",
  "messages": [
    {
      "level": "info",
      "key": "language",
      "code": "default",
      "args": {
        "key": "language",
        "default": "ruby"
      }
    }
  ],
  "full_messages": [
    "[info] on language: missing :language, defaulting to: ruby"
  ],
  "config": {
    "language": "ruby",
    "os": [
      "linux"
    ],
    "dist": "trusty",
    "sudo": false
  }
}
```

**Expand**

The body of the request should be the JSON config found in the response from **/v1/parse**. The response will contain the expanded matrix of jobs.

```
$ curl -X POST --data-binary @config.json /v1/expand | jq .
```

```json
{
  "version": "v1",
  "matrix": [
    {
      "os": "linux",
      "language": "ruby",
      "dist": "trusty",
      "sudo": false
    }
  ]
}
```
