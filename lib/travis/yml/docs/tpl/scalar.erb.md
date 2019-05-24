# <%= title %>

<%= description %>

<% if flags -%>
## Flags

<% flags.each do |flag| -%>
  * <%= flag %>
<% end -%>
<% end -%>

## Types

* <%= display_type %>

<% if examples.any? -%>
## Examples
<% examples.each do |example| %>
```yaml
<%= indent(yaml(example), 0) %>
```
<% end -%>
<% end -%>
