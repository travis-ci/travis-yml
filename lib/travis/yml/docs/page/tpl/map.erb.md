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

## Keys

<%= render(:mappings) %>
<% if includes.any? -%>
## Shared keys

<% includes.each do |include| -%>
<%= render(:include, include: include) %>
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
