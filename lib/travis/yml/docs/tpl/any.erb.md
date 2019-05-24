# <%= title %>

<%= description %>

<% if flags -%>
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

<% if mappings -%>
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
