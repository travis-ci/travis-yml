# <%= title_with_key %>

<% if summary %>
*<%= summary %>*
<% end %>

<% if root? %>
Welcome to the Travis CI build config reference documentation.

You can find the build config in the `.travis.yml` file in your repository. This site documents its format.

The Travis CI build config format is formally specified using a [JSON Schema](https://github.com/travis-ci/travis-yml/blob/master/schema.json). Travis CI uses this specification to normalize and validate build configs (this is currently in beta, and [needs to be
activated](https://docs.travis-ci.com/user/build-config-validation)).

Use the [Travis CI Build Config Explorer](/explore) to explore and experiment with build config YAML snippets.
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
