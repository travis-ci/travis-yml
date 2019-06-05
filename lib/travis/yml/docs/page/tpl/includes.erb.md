<% if includes.any? -%>
## Shared keys

<% includes.each do |include| -%>
<% include.map do |key, node| -%>
  * `<%= key %>`: <%= node.summary %> <% if node.path %>[details](<%= node.path %>)<% end %>
<% end -%>
<% end -%>
<% end -%>
