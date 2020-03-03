<% if known_on.any? -%>
## Known on

<% known_on.values.each do |node| -%>
  * [<%= node.title %>](<%= node.path %>)
<% end -%>
<% end -%>
