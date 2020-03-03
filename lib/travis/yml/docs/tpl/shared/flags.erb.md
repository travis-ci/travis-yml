<% if flags.any? -%>
## Flags

<% flags.each do |flag| -%>
  * [<%= flag.capitalize %>](<%= path_to(:flags) %>)
<% end -%>
<% end -%>
