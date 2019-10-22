# <%= title_with_key %>

<% if summary %>
*<%= summary %>*
<% end %>

<% if root? %>
This is the reference documentation for build configuration on Travis CI.
Build configuration usually is stored in the file `.travis.yml` in your
repository, but also can be sent via API.

You can explore, and experiment with build config YAML snippets using
the [config explorer](/explore).

The Travis CI build config format is formally specified using a [JSON
Schema](https://github.com/travis-ci/travis-yml/blob/master/schema.json).
This specification is used by Travis CI in order to normalize and
validate build configs (this is currently in beta, and [needs to be
activated](https://docs.travis-ci.com/user/build-config-validation)).
<% else %>
<%= description %>
<% end %>

<% if flags.include?(:expand) %>
The key `<%= key %>` is a [matrix expand key](/v1/docs/matrix_expand_keys), creating one or more additional jobs in your build matrix, depending how many other matrix expand keys are used.
<% end %>

<% if flags.include?(:edge) %>
The key `<%= key %>` is experimental and potentially might change or be removed.
<% end %>

<% if prefix %>
This node uses the key `<%= prefix[:key] %>` as a [default prefix](<%= path_to('types#map') %>) if not given a [map](<%= path_to('types') %>).
<% end %>

<%= render 'shared/deprecated' %>
<%= render 'shared/see' %>
<%#= render 'shared/known_on' %>
