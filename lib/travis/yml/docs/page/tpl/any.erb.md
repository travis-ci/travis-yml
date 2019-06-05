# <%= title %>

<%= description %>
<%= render :deprecated %>
<%= render :see %>
<%= render :parents %>
<%= render :flags %>
<%= render :types %>
<%= render :enum %>

<% if mappings && mappings.any? -%>
## Keys

If given a map, the following keys are supported:

<%= render(:mappings) %>
<% end -%>

<%= render :examples %>
