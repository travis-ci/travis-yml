# <%= title %>

<%= description %>

## Keys

<%= render(:mappings) %>
<% if includes.any? -%>
## Shared keys

<% includes.each do |include| -%>
<%= render(:include, include: include) %>
<% end -%>
<% end -%>
