<% if display_types.any? -%>
## Types

<% display_types.each do |str, path| -%>
  * [<%= str %>](<%= path %>)
<% end -%>
<% end -%>
