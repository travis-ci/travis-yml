# Multi language

People do the following:

```
matrix:
  include:
  - language: python
    ...
  - language: go
    ...
```

Others try doing:

```
language: node_js, csharp
```

I think we should make language a matrix key, i.e. allow multi language builds
as a first-class feature.

# Groups

Which groups do we have?

We currently allow stable and edge, defaulting to stable.

People also use: beta, dev, legacy, unstable.

# Compilers

What compiler versions to we support? The docs only mention clang and gcc, but
people are using specific versions, such as gcc-4.4, gcc-4.5, gcc-4.6, a lot.
There are also versions like ghc-7.10.3, arm-linux-gnueabihf-gcc,
i586-mingw32msvc-gcc, etc. There are so many of them that I am wondering if
they actually might work?

E.g. see https://github.com/fuzzylite/fuzzylite/blob/release/.travis.yml

I suggest to make this a simple scalar, instead of a fixed (known values).

Also, it seems like people use :compiler on languages other than C/C++:
https://github.com/ekmett/transformers-compat/blob/master/.travis.yml

So it should not be limited to C/C++, right.

Done. Made :compiler a simple scalar.

# Podfile

According to our docs :podfile is not a matrix key (https://docs.travis-ci.com/user/languages/objective-c/#Build-Matrix).

Should it?

Found only one repo that is trying to do this though.

# Custom config

There are tools that people use as part of their build that themselves
parse and use the .travis.yml file. E.g. https://github.com/mikkeloscar/arch-travis.

Such config keys would be dropped as they are unknown to us. We could:

* Advise to use a separate config file (e.g. `.travis.arch.yml` in this case)
* Allow a custom config key that accepts a hash with arbitrary keys (e.g. `custom`)


# Git submodules depth

Does not seem to be documented, but is being used:

https://github.com/travis-ci/travis-build/blob/ef82e82457f82c6518d090544bb533dc0faf0063/lib/travis/build/git/submodules.rb#L19


# Hashes on several deploy keys

Can these be hashes?

```
  edge:
    branch: releases-fix

  on:
    tag: true

  provider: lambda
  function_name:
    develop: Bridge-EX-Scheduler-dev
    uat: Bridge-EX-Scheduler-uat
    prod: Bridge-EX-Scheduler-prod
  role:
    develop: arn:aws:iam::649232250620:role/Bridge-EX-Scheduler-Dev
    uat: arn:aws:iam::649232250620:role/Bridge-EX-Scheduler-Uat
    prod: arn:aws:iam::649232250620:role/Bridge-EX-Scheduler-Prod

  provider: cloud66
  redeployment_hook:
    production: https://hooks.cloud66.com/stacks/redeploy/a10eaad53152560d60a989663c75cd6d/a792bf433ba5e754b4a5947245b92b4c

  provider: heroku
  run:
    master:
    - rake db:migrate
    - rake cleanup
    develop:
    - rake db:setup
```

# Deploy on branches: true

336 configs set:

```
deploy:
  on:
    branches: true
```

Isn't that completely bogus? Don't we always deploy on all branches except
if people specify a branch?

Also 397 configs set:

```
deploy:
  on:
   distributions: [something]
```

Is that not invalid? Does it do anything?

# Deploy on two sections

`deploy` is available both on `root` and on `addons`, ... which sucks hard.

The documentation only talks about `root.deploy`, so, remove `addons.deploy`?

# Dasherized and camelcase keys

We mix dasherized keys, and even camelcased keys, with regular underscored
keys, in deployment providers and addons.

Also, users actually use dasherized keys in their build configs a lot. E.g.
`after-success` instead of `after_success`.

We currently normalize these keys to always be underscored, and add a warning.
However, that probably breaks clients (dpl?, travis-build?).

I propose we keep this behaviour and change clients to be able to deal with
both versions for a transition period, then standardize on underscored keys
everywhere once travis-yaml is in use.

In some cases we already seem to accept both underscored and camelized keys:

https://github.com/travis-ci/travis-build/blob/master/lib/travis/build/addons/browserstack.rb#L147-L161


# Sequence on matrix.include and matrix.allow_failure

People use arrays on `matrix.include` a lot, even though the documentation specifically
says that a hash given on this array represents a job (see https://docs.travis-ci.com/user/customizing-the-build#Explicitly-Including-Jobs).

Expanding these would add even more complexity to this section, and I think we should
disallow them.

The same is true for `matrix.allow_failure`.

Example:

```
# wrong
matrix:
  include:
  - os: linux
    language: java
    jdk:
    - openjdk7
    - openjdk6
    script: ant build

# correct
matrix:
  include:
  - os: linux
    language: java
    jdk: openjdk7
    script: ant build
  - os: linux
    language: java
    jdk: openjdk6
    script: ant build
```

# Sequence on addons

People sometimes use a sequence with a nested Hash on `addons` and some other
keys, instead of a plain Hash.

We "pick" the first element from such arrays.

```
# wrong
addons:
- firefox: '17.0'

# correct. the above is normalized to this
addons:
  firefox: '17.0'
```

# Disabling notifications

People use things like:

```
notifications: false

notifications:
  disabled: true
```

I'm not sure where that's coming from, but email notifications can be (iirc)
disabled by specifying either of these:

```
notifications:
  email: false

notifications:
  email:
    disabled: true
```

# Job stages after_install and after_error

A significant number of people expect the job stages after_install and
after_error to work, even though they do not exist.

They have been added to the spec at the moment. I suggest we add them to
travis-build as well (should be minimal change, right).

# What the hell is dd?

A significant number of configs have a key `dd` which, in almost all cases,
has a single secure string on it. I've googled for this, but couldn't figure
out what it is.

# Root level mysql and postgresql keys

There are over 1K unknown key errors for a root level `mysql` or `postgresql`
key. They do things like:

```
mysql:
  database: "$DATABASE"
  username: "$DB_USERNAME"
  encoding: "$DB_ENCODE"

postgres:
  adapter: postgresql
  database: myapp_test
  username: postgres
```

Is that a thing we support?

# Addons vs services

There are services like mariadb and postgresql, but no service mysql. On the
other hand there are the addons mysql and postgresql, but no service mariadb.

Can this be consolidated into one thing? Seems confusing, lots of people have
wrong keys on one or the other.


# Secure strings

At some point we should reconsider how we mark strings as secure (encrypted). I
think the choice we made back then, choosing a Hash with a single key `secure`,
was a little odd, and it adds quite some complexity.

Instead we could prefix the string with a marker, like `[secure]gmTbelt0Qm...`.
This way a string is a string, and a Hash never represents a string, and it
would be much less prone to getting the YAML formatting wrong.

The transition and staying backwards compatible would be easy, too. Once all
clients were able to deal with the new format we could simply normalize
incoming Hashes to this format.

# Using :secret instead of :secure

Some people seem to be using `:secret` as a key for secure strings. I think
we should continue rejecting this, and display the respective error message.

```
# wrong
addons:
  code_climate:
    repo_token:
      secret: PcELOOKricWCW1V3mEFWbqRRdLo3zJll

# correct
addons:
  code_climate:
    repo_token:
      secret: PcELOOKricWCW1V3mEFWbqRRdLo3zJll
```

# Casher branch

It seems we have two ways of specifying a branch for casher. From travis-build:

```
def casher_branch
  if branch = data.cache[:branch]
    branch
  else
    data.cache?(:edge) ? 'master' : 'production'
  end
end
```

As far as I understand this would accept both this:

```
cache:
  branch: md5deep
```

and this:

```
cache:
  edge: md5deep
```

Do we need both? Can the former version be deprecated in favor of the latter
one?

# Rollout path

We can run this silently in Gatekeeper for a while as a first stage. We'd just
check the config, but still use the old logic to configure the build and jobs.
We'd just store messages, and only display them in admin (or even a trivial cli
script).

As a second stage we could add the messages to the UI, hidden behind a feature
flag.

As a third stage we could make this a public feature flag in the UI, and allow
users to opt into using travis-yml to actually process the config, and use this
for configuring their builds.

We could then add new features (such as build stages, new addons etc) to the
new format exlusively, and tell people to migrate to the new format in order to
get access to these features. We could keep this mode up for a long time to
have plenty opportunity to continuously tweak things and fix potential bugs.

We could then tell people that the old format is now deprecated, and will be
disabled after, like, another 6 months or so.

After that time we could then finally get rid of the old logic, and fully
switch over.
