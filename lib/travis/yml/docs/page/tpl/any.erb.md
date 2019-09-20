# <%= title %>

<%= render 'shared/description' %>
<%= render 'shared/deprecated' %>
<%= render 'shared/see' %>
<%= render 'shared/parents' %>
<%= render 'shared/types' %>
<%= render 'shared/enum' %>

<% if mappings && mappings.any? -%>
## Keys

If given a map, the following keys are supported:

<%= render 'shared/mappings' %>
<% end -%>

<%= render 'shared/examples' %>
