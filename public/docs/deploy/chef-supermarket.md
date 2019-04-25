# Deploy Chef Supermarket



## Types

* Hash
* String (known)

## Values

* `chef-supermarket`


## Examples

```yaml
deploy:
  provider: chef-supermarket
  on: {}
  allow_failure: true
  skip_cleanup: true
  edge: true
  user_id: 
  client_key: 
  cookbook_category: string
```

```yaml
deploy: chef-supermarket

```
