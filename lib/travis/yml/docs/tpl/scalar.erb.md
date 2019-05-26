# <%= title %>

<%= description %>

<% if deprecated? -%>
*Deprecated: <%= deprecated %>*
<% end -%>

## Known on

<% parents.select(&:id).each do |parent| -%>
  * [<%= parent.title %>](<%= parent.path %>)
<% end -%>

<% if flags.any? -%>
## Flags

<% flags.each do |flag| -%>
  * <%= flag %>
<% end -%>
<% end -%>

## Types

* <%= display_type %>

<% if enum -%>
## Known values

<% enum.each do |value| -%>
  * `<%= value %>`
<% end -%>
<% end -%>

<% if examples.any? -%>
## Examples
<% examples.each do |example| %>
```yaml
<%= indent(yaml(example), 0) %>
```
<% end -%>
<% end -%>
