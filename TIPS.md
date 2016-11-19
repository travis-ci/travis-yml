# Tips

## Using YAML references

It is recommended to use one `deploy` section per target, e.g. per branch.

For example:

```
deploy:
  - provider: s3
    bucket: production_bucket
    on:
      branch: production
  - provider: s3
    bucket: staging_bucket
    on:
      branch: staging
```

However, if you need to set many other attributes, maybe including secure values,
then this can become pretty verbose.

In such cases YAML's reference feature can come in handy:

```
deploy:
  - &s3
    provider: s3
    access_key_id:
      secure: ...
    secret_access_key:
      secure: ...
    region: eu-central-1
    bucket: production_bucket
    on:
      branch: production
  - <<: *s3
    provider: s3
    bucket: staging_bucket
    on:
      branch: staging
```

This results in:

```
{
  "deploy": [
    {
      "true": {
        "branch": "production"
      },
      "provider": "s3",
      "bucket": "production_bucket",
      "region": "eu-central-1",
      "access_key_id": {
        "secure": "..."
      },
      "secret_access_key": {
        "secure": "..."
      }
    },
    {
      "true": {
        "branch": "staging"
      },
      "provider": "s3",
      "bucket": "staging_bucket",
      "region": "eu-central-1",
      "access_key_id": {
        "secure": "..."
      },
      "secret_access_key": {
        "secure": "..."
      }
    }
  ]
}
```

We recommend referencing, and reusing an existing entry, instead of adding
extra keys, e.g. on the root section, as this would yield extra warnings and
can, potentially, break your config in unexpected ways.

Another example is using references on the `matrix.include` section:

```
matrix:
  include:
    - &job
      compiler: gcc
      apt:
        packages:
        - gcc-multilib
    - <<: *job
      compiler: clang
```

This results in:

```
{
  "matrix": {
    "include": [
      {
        "apt": {
          "packages": [
            "gcc-multilib"
          ]
        },
        "compiler": "gcc"
      },
      {
        "apt": {
          "packages": [
            "gcc-multilib"
          ]
        },
        "compiler": "clang"
      }
    ]
  }
}
```

The following is an example of extra keys added to the root section, which will
result in validation warnings and errors.

*This syntax is not recommended.*

```
_packages:
- &1
  apt:
    packages:
    - gcc-multilib
matrix:
  include:
  - env:
      FOO=foo
    addons: *1
  - env:
      BAR=bar
    addons: *1
```

Instead, we recommend folding the reference entry into the `matrix.include` section
like so:

```
matrix:
  include:
  - env:
      - FOO=foo
    addons: &addons
        apt:
          packages:
          - gcc-multilib
  - env:
      - BAR=bar
    addons: *addons
```

Or:

```
matrix:
  include:
  - &job
    env:
      - FOO=foo
    addons:
        apt:
          packages:
          - gcc-multilib
  - *job
    env:
      - BAR=bar
```

# Common YAML mistakes

## Nesting maps in sequences

Starting a line with a dash `-` indicates an entry in a sequence. Sometimes
that is not intended. For example the following YAML:

```
deploy:
  - provider: heroku
```

would result in:

```
{
  "deploy": [
    {
      "provider": "heroku"
    }
  ]
}
```

Instead a simple map is required here, so omitting the dash is important:

```
deploy:
  provider: heroku
```

This results in:

```
{
  "deploy": {
    "provider": "heroku"
  }
}
```

## Unquoted command containing a colon

In YAML an unquoted line with a colon will result in a map. For example the
following YAML:

```
after_script:
- echo "========== test log: ============"
```

results in this:

```
{ after_script: [ { 'echo "========== test log': '============"' } ] }
```

Note the command was split into a map.

To solve this either extract the command into a file, or quote the command:

```
after_script:
- 'echo "========== test log: ============"'
```

Results in:

```
{ after_script: [ 'echo "========== test log: ============"' ] }
```

Our parser will try fixing this mistake, and gets it right in many, but not all
cases.

## Broken nesting

In YAML nesting is crucial.

The following looks like mistakenly hitting the tab key once broke the nesting:

```
addons:
  postgresql: '9.4'
  before_script:
  - psql -c 'create database peepchat_test;' -U postgres
```

This should have been:

```
addons:
  postgresql: '9.4'
before_script:
  - psql -c 'create database peepchat_test;' -U postgres
```
