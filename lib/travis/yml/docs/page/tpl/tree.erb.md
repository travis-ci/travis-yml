# Tree

<% pages.each do |page| -%>
* [<%= page.title %>](<%= page.path %>)
<% Array(page.children).each do |child| -%>
  <%= render('tree/node', child, opts) %>
<% end -%>
<% end -%>

