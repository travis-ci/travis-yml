* [<%= title %>](<%= path %>)
<% pages.each do |node| -%>
* [<%= node.menu_title %>](<%= node.path %>)
<% active?(node) && Array(node.children).each do |child| -%>
  * [<%= child.menu_title %>](<%= child.path %>)
<% end -%>
<% end -%>
