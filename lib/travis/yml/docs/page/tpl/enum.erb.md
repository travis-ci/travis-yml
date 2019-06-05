<% if enum -%>
## Known values

<% enum.each do |value| -%>
  * `<%= value %>`
<% end -%>
<% end -%>
