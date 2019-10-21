# Matrix Expansion

A build contains one or more jobs to run in parallel or [stages](<%= path_to('ref/stages') %>).

These jobs come out of the build matrix expansion. Additional jobs can be added
manually using the [matrix](<%= path_to('ref/matrix') %>) key.

The build matrix expansion is driven by matrix expansion keys that are defined
in the build configuration. If no expansion keys are given, or they only have
a single value each, then the resulting build will only have a single job.

For example, the keys `os` and `python` (on Python builds) are matrix expansion
keys.

If just `os` is given as:

```yaml
os:
- linux
- osx
```

Then the resulting build will have two jobs, one configured to run on `os:
linux`, one on `os: osx`.

If both `os` and `python` are given as:

```yaml
os:
- linux
- osx

python:
- 2.7
- 3.6
- 3.7
```

Then the resulting build will have 6 jobs, combining each `os` with each one of
the `python` versions.

## Matrix expansion keys

The following expansion keys are known:

* `os`
* `arch`
* `env.matrix` (also `env` due to [normalization of maps](<%= path_to('types#map') %>), if no key `global` or `matrix` is present)

The following expansion keys are supported depending on the [language](<%= path_to('ref/language') %>) selected:

<% Yml.expand_keys.-(%i(os arch matrix)).each do |key| %>
* `<%= key %>`
<% end %>
