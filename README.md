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
levels `info`, `warn`, and `error`. Messages include a message code (e.g.
`unknown_key`, `unsupported_value` etc.) and metadata (e.g. the given key,
value) so they can be translated to human readable messages. These can be used
in the UI, and links to the documentation, suggesting fixes.

```ruby
yaml = 'rvm: 2.3'
config = Travis::Yaml.load(yaml)

config.serialize
# {
#   language: 'ruby',
#   os: ['linux'],
#   dist: 'trusty',
#   sudo: false
# }

config.msgs
# [
#   [:info, :language, :default, key: :language, default: 'ruby'],
#   [:info, :root, :alias, { alias: :rvm, name: :ruby }]
# ]

config.msgs.map { |msg| Travis::Yaml.msg(msg) }
# [
#   '[info] on root: missing :language, defaulting to: default',
#   '[info] on language: :rvm is an alias for :ruby, using :ruby'
# ]
```

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

Some scalars are marked as wanting a `Secure`, so we can alert the user if they
pass a string.

# Build config specification

The spec is included to the repository as [spec.json](https://github.com/travis-ci/travis-yml/blob/master/spec.json).

The spec is defined in `Spec::Def`, and can be produced by:

```ruby
Travis::Yaml.spec
```

Classes in `Spec::Def` use classes in `Spec::Type` to build a tree of nodes
that define allowed keys, types, and various options in a readable and succinct
way (using a DSL for describing the spec).

This tree is then serialized to a lengthy Hash which serves as a specification,
and both an internal and, optionally, external API.

A good starting point for exploring the definition is the [root node](https://github.com/travis-ci/travis-yml/blob/master/lib/travis/yaml/spec/def/root.rb).

Examples for various nodes on this specification can be found in the tests, e.g.
for the [git](https://github.com/travis-ci/travis-yml/blob/master/spec/travis/yaml/spec/def/git_spec.rb),
[heroku](https://github.com/travis-ci/travis-yml/blob/master/spec/travis/yaml/spec/def/deploy/heroku_spec.rb), or
[os](https://github.com/travis-ci/travis-yml/blob/master/spec/travis/yaml/spec/def/os_spec.rb) nodes.

Most nodes can be sufficiently specified by mapping known keys (e.g.
`language`) to types (`fixed`, `scalar`, `map`, `seq`) with certain options,
such as:

* `values`: known values on a `scalar` type
* `default`: default value
* `required`: the node has to have a value
* `cast`: try casting the node value to another type
* `edge`: the node represents an experimental feature
* `flagged`: the node represents a feature that requires a feature flag
* `only`: the node is valid only if the given value matches the current `language` or `os`
* `except`: the node is valid only if the given value does not match the current `language` or `os`
* `expand`: the node represents a matrix key for matrix expansion

The fully expanded spec would be huge due to the repition of large sections
that need to be included on N+1 child sections. For example, the `deploy.on`
(which is allowed on currently 42 deployment providers) section allows to
include all language specific sections, such as `rvm`, `python` etc., and so do
the `matrix.include`, `matrix.exclude`, and `matrix.allow_failures` sections.

In order to keep the JSON payload reasonably small nodes can specify an option
`include` in order to include shared sections. Shared sections are kept on the
key `includes` on the root node and will be expanded into the respecitive
target nodes at load time, and kept in memory from there on. We currently have
2 sections that can be included:

* `job` (shared by `root`, `matrix.*`, keys like `addons`, `branches`, `caches` etc.)
* `support` (language specific keys, such as `rvm`, `python` etc.)

# Loading the spec

Before the spec can be applied to an actual build configuration it will be
expanded (i.e. shared sections will be included to nodes that require them),
and turned into an object oriented representation, so non-parametrized methods
can be memoized for better performance.

The method `Travis::Yaml.expanded` returns the fully expanded, object oriented
tree.

# Applying the spec to a build config

This representation of the spec can be applied to a build configuration by:

```ruby
# given a YAML string
Travis::Yaml.load(yaml)

# given a Ruby hash
Travis::Yaml.apply(config)
```

Both methods also accept an optional options hash. There is one known option:

```ruby
Travis::Yaml.apply(yaml, alert: true)
```

The option `alert` rejects plain strings and adds an error message on nodes
that expect a secure string.

When the spec is applied to a build configuration three things happen:

* The config is turned into an object oriented representation as well by the
  way of calling `Doc::Value.build`. This method uses classes in `Doc::Value`
  in order to build a tree of nodes that maps to the given build config hash.

* The config structure is normalized by the way of calling `Doc::Change.apply`.
  This method applies various strategies in order to attempt to fix potential
  problems with the given structure, such as typos, misplaced keys, wrong
  section types. In some cases it will store messages on the resulting tree.
  Change strategies are determined based on the type of the given node. Some
  strategies can be required by the spec for certain sections that need very
  specific normalizations, such as `cache`, `env`, `notifications`.

* The resulting config is validated by the way of calling `Doc::Validate.apply`.
  This method applies various validations, and sets default values. It also
  stores (most of the) messages on the resulting tree. Sections also can
  require specific validations. The only section specific validation currently
  is `template` (which validates used var names in notification templates).

Examples of type specific change strategies:

* `alert`: unset the value if the given value is a string while a secure string is expected
* `cast`: try casting the value to another type if required by the spec (e.g. the string `"true"` to the boolean `true`)
* `downcase`: downcase a string if required by the spec
* `keys`: add required keys, and attempt to fix an unknown key by removing special chars and finding typos (uses a dictionary, as well levenshtein and similar simple strategies)
* `merge`: merge an sequence of maps into a single maps if the spec requires a map (common mistake)
* `migrate`: move the section to either a child or parent section if the key is known on that section and the resulting section validates without errors
* `pick`: pick the first value of a given sequence for a scalar node
* `repair`: repair bash command strings that have been broken up into maps by the YAML parser (e.g. `script` strings that contain an unescaped colon)
* `value`: de-alias fixed node values, and try fixing typos in unknown values
* `wrap`: wrap the given node into a sequence if required by the spec (e.g. `os` needs to result in an array)

Section specific change strategies:

* `enabled`: normalize `enabled` and `disabled` values, set `enabled` if missing (used by, for example, `notifications`)
* `inherit`: inherit certain keys from the parent node if present (used by, for example, `notifications`)

Examples of the validations:

* `alias`: use the other value if the given value is an alias for another value
* `default`: use a default value as required by the spec if the node does not have a value
* `edge`: add an `info` level message if this node type is used (experimental features)
* `empty`: drop an empty section
* `flags`: add an `info` level message if this node type is used (features that require a feature flag)
* `format`: unset the value and if the given value does not conform with the format as required by the spec
* `invalid_type`: unset the value if the given value's type is not compatible with the spec's node type
* `required`: drop an empty node if the node is required by the spec
* `template`: drop the value if the given template string uses unknown variables
* `unknown_keys`: drop unknown keys from a strict map
* `unknown_value`: drop unknown values from a fixed type
* `unsupported_key`: unset the value if the given key is not compatible with the current language or os, as defined by the spec
* `unsupported_value`: unset the value if the given fixed value is not compatible with the current language or os, as defined by the spec

Section specific validations:

* `template`: unset the value if unknown variable names are used in a notification template

## Summary

There are three sets of classes that are used to build trees:

* `Travis::Yaml::Spec` builds the static, unexpanded Ruby hash that can be served as JSON.
* `Travis::Yaml::Doc::Spec` is used to build an object oriented tree of nodes from the expanded spec.
* `Travis::Yaml::Doc::Value` is used to build an object oriented tree of nodes that represent the given build config.

Only the last one, `Doc::Value`, is re-used at runtime, i.e. only for the given
build configs we build new trees. The `Doc::Spec` representation is kept in
memory, is static, and remains unchanged.

For each build config we then apply all relevant changes (`Doc::Change`) and
all relevant validations (`Doc::Validate`) to each node.

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

# Tests

Tests can be run against YAML examples contained in the documentation. These
are not executed by default, but need to be opted in to either by defining an
env var `DOCS` or running the file `spec_docs_spec.rb` only.

```
cd ..
git clone https://github.com/travis-ci/docs-travis-ci-com.git
cd -
bin/docs

# run all tests
DOCS=true rspec

# run documentation tests
rspec spec/docs_spec.rb
```

# Includes

(TODO join with the above?)

The format supports the concept of includes. I.e. a node can list certain
global sections that it wants to include. Clients are then supposed to
merge the included sections to the given node.

We are using this for language support keys and keys (such as `gemfile` and
`ruby` that are allowed only on the language `ruby`), and other keys that are
shared between the root node and the nodes `matrix.include`, `matrix.exclude`,
and `matrix.allow_failures`.

The reason we are doing this is to keep the spec at a reasonable size. If
we would not share these keys the spec size would explode from ~600K to
over 14MB (when formatted as pretty printed JSON, i.e. including lots of
whitespace).

The specification for language support keys like `gemfile` and `ruby` takes up
some space as follows:

We have 29 languages. They provide 63 such keys in total. Each of these keys
takes up at ~300 to 800 bytes (when pretty formatted as JSON). The full
`support` node that holds these keys, including whitespace, is 20238 bytes big.

Now these keys are not only relevant on the root node, but also relevant on the
`matrix.include`, `matrix.exclude`, and `matrix.allow_failures` nodes, as well
as the deployment conditions `on` node. Also, again, the deployment provider
nodes are not only relevant on the root node, but on the 3 `matrix.*` nodes
mentioned. We have 41 deployment providers at the moment.

So we'd need to include these 63 keys `4 + 4 * 41` times, taking up ~3.4MB
space.

On top of that, a couple other huge keys are shared between the root node, and
the 3 `matrix.*` nodes mentioned, such as the `addons` node, which is ~240K
big, and the `deploy` node, which is ~170K big (not counting the language
support keys discussed before).

Because of the deep nesting that these keys then have, a huge amount of
additional whitespace is added on top of that, resulting in a total spec size
of ~20MB, making the spec pretty much impossible to read for humans, and
expensive to download (in case we'd want to use it in JS client for example).
