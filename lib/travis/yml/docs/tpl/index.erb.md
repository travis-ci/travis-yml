<% pages.each do |page| -%>
* [<%= page.title %>](<%= page.path %>)
<% if active?(page) -%>
<% Array(page.children).each do |page| -%>
  * [<%= page.title %>](<%= page.path %>)
<% end -%>
<% end -%>
<% end -%>

