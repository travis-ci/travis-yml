<% pages.each do |page| -%>
* [<%= page.title %>](<%= page.path %>)
<% Array(page.children).each do |child| -%>
  * [<%= child.title %>](<%= child.path %>)
<% end -%>
<% end -%>

