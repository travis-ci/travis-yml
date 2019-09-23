  * [<%= title %>](<%= path %>)
  <% Array(children).each do |child| -%>
    <%= child.render('tree/node') %>
  <% end -%>
