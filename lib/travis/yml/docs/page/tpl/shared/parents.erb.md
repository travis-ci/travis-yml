<% if parents.any? -%>
## Known on

<% parents.select(&:id).each do |parent| -%>
  * [<%= parent.title %>](<%= parent.path %>)
<% end -%>
<% end -%>
