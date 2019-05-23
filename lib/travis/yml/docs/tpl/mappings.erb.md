<% map do |key, node| -%>
  * `<%= key %>`: <%= node.summary %> <% if node.path %>[details](<%= node.path %>)<% end %>
<% end -%>
