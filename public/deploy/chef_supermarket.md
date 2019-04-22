# Chef Supermarket



## Type

Any of:

* Map (Hash)
* Enum (known String)

## Flags

None.


## Examples

```yaml
deploy:
  provider: chef_supermarket
  on: "[ref:type/deploy_conditions]"
  allow_failure: true
  skip_cleanup: true
  edge: "[ref:type/deploy_edge]"
  user_id: 
  client_key: 
  cookbook_category: string
```

```yaml
deploy: chef_supermarket

```
