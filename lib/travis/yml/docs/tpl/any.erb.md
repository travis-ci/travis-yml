<%= render 'shared/description' %>
<%= render 'shared/types' %>
<%= render 'shared/enum' %>

<% if mappings && mappings.any? -%>
## Keys

If given a map, the following keys are supported:

<%= render 'shared/mappings' %>
<%= render 'shared/includes' %>
<% end -%>

<%= render 'shared/examples' %>
