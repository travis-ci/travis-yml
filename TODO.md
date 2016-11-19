* remove the human readable string from msgs, store values instead (?)
* drop cast? just use secure: true

* complete accept/lang specs
* compare languages with travis-build

* talk to Hiro/Henrik about what's actually supported on osx
* confirm the SafeYaml patch does not mess with AR deserialization

# Missing features?

* `after_install` and `after_error` are not a thing in travis-build, but a lot of people are using them
* webhooks `on_start` doesn't exist in hub (right?) but it's documented  https://docs.travis-ci.com/user/notifications#Webhook-notifications
* people expect `before_cache` to work
