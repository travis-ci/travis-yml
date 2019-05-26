<% mappings.each do |key, node| -%><% next if node.internal? %>
  * `<%= key %>`<% if node.info %> &mdash; <%= node.info %><% end %>
<% end -%>
