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

<% if display_types.any? -%>
## Types

<% display_types.each do |type| -%>
  * <%= type %>
<% end -%>
<% end -%>

<% if enum -%>
## Known values

<% enum.each do |value| -%>
  * `<%= value %>`
<% end -%>
<% end -%>

<% if mappings && mappings.any? -%>
## Keys

If given a map, the following keys are supported:

<%= render(:mappings) %>
<% end -%>

<% if examples.any? -%>
## Examples
<% examples.each do |example| %>
```yaml
<%= indent(yaml(example), 0) %>
```
<% end -%>
<% end -%>
