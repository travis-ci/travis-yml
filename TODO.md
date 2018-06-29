Looks like `allow_failures` can be restricted to a branch like this: https://github.com/BanzaiMan/travis_production_test/blob/91830a6bcb4dca4313e84439c376ed61547c4d6b/.travis.yml#L9-L12





* spec all classes in spec/doc
* compare languages with travis-build
* talk to Hiro about what's actually supported on osx
* confirm the SafeYaml patch does not mess with AR deserialization
* create a list of common mistakes (e.g. how to comment in yaml, don't nest hashes in arrays)


# Dpl providers

according to dpl:

  cloudcontrol has closed
  transifex is missing


# Missing features?

* how about making both language and dist matrix keys? i.e. multilanguage builds? should be trivial to add
* `after_install` and `after_error` are not a thing in travis-build, but a lot of people are using them
* people expect `before_cache` to work
* super inconsistent across notification types `notifications.irc.on_pull_requests: true`
* add cache `node_modules`, `npm`?


# Can :edge be a Hash?

```
deploy:
  provider: deis
  edge:
    source: loicmahieu/dpl
    branch: fix/deis/remove-key
```


Also, what about these?

```
648168 [invalid_type] deploy.edge bool map
480020 [invalid_type] deploy.function_name str map
539889 [invalid_type] deploy.redeployment_hook str map
480020 [invalid_type] deploy.role str map
532148 [invalid_type] deploy.run str map
```

# Can :run be a Hash with Arrays?

```
deploy:
  provider: heroku
  run:
    master:
    - rake db:migrate
    - rake cleanup
    develop:
    - rake db:setup
```
