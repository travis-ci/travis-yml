# Deploy Pages



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: pages
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  github_token: 
  repo: string
  target_branch: string
  local_dir: string
  fqdn: string
  project_name: string
  email: string
  name: string
  github_url: string
  keep_history: true
  verbose: true
  allow_empty_commit: true
  committer_from_gh: true
  deployment_file: true
```

```yaml
deploy: pages

```
