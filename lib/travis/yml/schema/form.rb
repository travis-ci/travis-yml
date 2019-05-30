# frozen_string_literal: true
#
# Behold, the lands of transformers, shapeshifters, and (gasp) ...
#
#                     .......
#                       '.   ''..
#                        |       "'.
#                        /          ''.
#                      ./              ''.
#                   ..".                  '.
#   .....""\::......'   '"'...             ':.
#    ''..         '""'.:.'..  '"'..          "'\
#       '".   '.         "" '''... '"'..      '.'.
#          ".   \.        ""'... .''..  ''... ./  '.
#            \   ''..           \.'".."'..  "..     ".
#             \     .' ".     '"  '.  '"..'\.  '.    '.
#              |  .     .\.. "'     ''..../"."\. '\.   '.
#              |.'        ............     \|'\.'. '\.   .
#             | ...'\::.  '""""""""' ...../""'..".'. '\   \
#            /   ""'          ''      .  |  """ /:' '. ".  \
#           "".    '"""  ...." .'' ' '. '"":::::::| .''.'\  \
#              ".  """'./'  '";  ..'"..'/"   ..."" .:"..\ ". |
#                \           ."".. "' ' |  / /\.""'    ./:./ |
#                '     ..  ..'"     .'./  / ."     .."'   '/ \
#                 |..'" .'" .     ..'/' ." /'   ./'  ...''."'.\
#                /__ ""      '\..'' ..".' /    .' ."'        '..
#                    "'.  '"."  .../'.'  /    .'./             '
#                       ".  |  .\/'""/. |'    |  |
#                        '\ '.".' .'\. \ \    .  |.          ".
#                         './\'  "   \  \.\./""":'|..        '\
#                         |:'  ... |  '. '.'\. '\    "'.  \.  \\
#                        .:\...    |   '  :  '". '   ."|   \.  :\.
#                             '/..   ..  ''           '.\   \/.'.'.
#                            ." |/./"      ..../ '".    "\   '."/./..
#                           .'  /'     ..""  |.'    :..   '""""\.    \
#                          /' ."     ./' |.  \'    ."'.""     |/   '" '..
#                         /  /'."' ""\/  '| /' \."   .\..    ./          \
#                        |' |\"'.     '.  |\.    '""\.  '::/"./   .://'   \
#                       .'  |/. ''.    '| |. |:| ...  '/".  '\  """\":/". '
#                       /  ||. ".../:|  | .\"'\    ./ .|  \ |'.    '\ \  \|
#                       |  |'::..   .  .::'"\.:   .:/\/'  '|/\\      '.\ ''
#                       . || |"::::"' /'    |\' /"\//'    .\'||
#                       | '| |...//  .'  ....   .""       // ||
#                       |  ||'  / | .' ." ./.".         ./"  ||
#                       |  ||  /| | /''.\/|'|/|              '
#                       .  \ \ \ .. ./' |\"\/||
#                        \ '. \ \  "'   "  / '
#                         \ '. '."'.      '
#                          ". ". "..'"'..                      -hrr-
#                            ". "'..""'.:""..
#                              "'..  "'.  '"'"':..
#                                  '"....""'..'". ".
#                                        '"" .    " "..
#                                              '"\: .  \
#                                                  '\:  '.
#                                                     '\  \
#                                                       '. \
#                                                         ' \
#                                                          '.\
#                                                            '

module Travis
  module Yml
    module Schema
      module Form
        extend self

        # Applies well defined patterns to Maps and Seqs in order to transform
        # the given type to an Any with alternative forms.

        def apply(node)
          node = Node.form(node)
          # puts node.dump(mark: 'export: true')
          node
        end

        class Node
          include Helper::Obj, Registry

          class << self
            def form(node)
              return node unless registered?(node.type)
              # caching(node) { self[node.type].new.apply(node) }
              self[node.type].new.apply(node)
            end

            # def caching(node)
            #   if node.id && cache.key?(node.id)
            #     cache[node.full_id]
            #   elsif cache.key?(node.object_id)
            #     cache[node.object_id]
            #   else
            #     other = yield
            #     cache[node.object_id] = other
            #     cache[node.full_id] = other if node.id
            #     other
            #   end
            # end
            #
            # def cache
            #   @cache ||= {}
            # end
          end

          def form(node)
            self.class.form(node)
          end
        end

        class Schema < Node
          register :schema

          def apply(node)
            map = node.shapeshift(:map)
            map.mappings.replace(node.mappings)
            map.includes.replace(node.includes)
            map.unset :title, :description
            map = form(map)

            all = node.shapeshift(:all)
            all.set :title, node.title
            all.unset :mappings
            all.types = [map]
            all
          end
        end

        # class Group < Node
        #   register :any
        #   register :all
        #   register :one
        #
        #   def apply(node)
        #     # node.types.replace(node.types.map { |node| form(node) })
        #     node
        #   end
        # end

        class Map < Node
          register :map

          def apply(node)
            # node = form_includes(node) if node.includes?
            # node = form_map(node)

            other = includes(node) if node.includes?
            other = prefix(other || node, node[node.prefix[:key]], node.prefix) if node.prefix?
            other = enable(other || node) if node.change?(:enable)
            other = typed(other  || node) if node.types.any?

            node = other || node
          end

          def form_map(node)
            map = node.mappings.map { |key, node| [key, form(node)] }.to_h
            node.mappings.replace(map)
            node
          end

          def form_includes(node)
            includes = node.includes.map { |node| form(node) }
            node.includes.replace(includes)
            node
          end

          # If a Map has any includes then we turn this into an All holding
          # the Map and all of its includes.
          #
          # E.g.:
          #
          #   map(includes: [a, b]) -> all(map, a, b)
          #
          def includes(node)
            all = node.shapeshift(:all)
            all.unset :prefix, :aliases, :changes, :includes, :normal, :required, :unique
            all.types = [node, *node.includes].map(&:dup)

            all.types.each.with_index do |node, ix|
              node.set :export, false if ix == 0
              node.set :normal, nil
              node.parent = all
            end

            all
          end

          # If the Map has a prefix we also accept the form of the schema
          # mapped with the prefix key. Therefore the Map gets transformed
          # to an Any with the same Map, and the schema mapped with the
          # prefixed key.
          #
          # E.g. if the prefixed key maps to a Str then we return an Any with
          # a Map and a Str:
          #
          #   map(foo: str) -> any(map(foo: str), str)
          #
          def prefix(node, child, prefix)
            any = node.shapeshift(:any)
            any.unset :aliases, :changes, :prefix, :required, :unique
            any.types = [node, child].map(&:dup)

            # child.example = node.examples[prefix]

            any.types.each.with_index do |node, ix|
              node.unset :description, :summary, :title
              node.set :export, false if ix == 0
              node.set :normal, ix == 0 ? true : nil
              node.unset :aliases if ix > 0
              node.parent = any
            end

            any
          end

          # If the Map has a type (i.e. it is not strict) we also accept the
          # type. Therefore the Map gets transformed into an Any with the same
          # Map, and the Map's type.
          #
          # E.g. if the Map's schema is Str:
          #
          #   map(type: str) -> any(map, str)
          #
          # This is useful e.g. for deploy providers that want to accept a
          # secure or a map with arbitrary keys that map to secures, like
          # Heroku.
          #
          def typed(node)
            any = node.shapeshift(:any)
            any.types = [node, *node.types].map(&:dup)
            any.unset :prefix, :aliases, :changes, :normal, :required, :unique

            any.types.each.with_index do |node, ix|
              node.parent = any
            end

            any
          end

          # If the Map allows the change :enable we also want to accept a
          # boolean.
          #
          # E.g.
          #
          #   map(change: enable) -> any(map, bool)
          #
          def enable(node)
            if node.type == :any
              any = node
            else
              any = node.shapeshift(:any)
              any.types = [node].map(&:dup)
              any.unset :aliases, :changes
            end

            any.types << Type::Bool.new(node.parent)

            any.types.each.with_index do |node, ix|
              node.unset :description, :summary, :title
              node.set :export, false if ix == 0
              node.set :normal, ix == 0 ? true : nil
              node.parent = any
            end

            any
          end
        end

        class Seq < Node
          register :seq
          register :strs

          def apply(node)
            return node if node.is?(:strs, :secures)
            node.types << Type::Str.new(node) unless node.types.any?
            # node = form_seq(node)
            node = wrap(node)
            node
          end

          def form_seq(node)
            node.types.replace(node.types.map { |node| form(node) })
            node
          end

          # For each of the Seq's types we want to include a Seq with that
          # schema, plus the schema itself.
          #
          # E.g. a Seq with a single Str schema should become an Any with the
          # same Seq, and the same Str:
          #
          #   seq(str) -> any(seq(str), str)
          #
          # If the first schema is an Any then this was just transformed from a
          # prefixed Map. In this case case want to use this Any's types to
          # replace the Seq's types.
          #
          # I.e. a Seq with an Any that has a Map and a Str needs to become
          # an Any with the types:
          #
          #   seq(map, str) -> any(seq(any(map, str)), map, str)
          #
          # ... because JSON Schema does not allow multiple types on a seq.
          #
          # Btw deploys needs to be:
          #
          #   seq(any(providers)) -> any(seq(any(providers)), any(providers))
          #
          def wrap(node)
            # this breaks seq(:deploys, providers)
            #
            # types ||= node.first.is?(:any) ? node.types.first.types : node.types
            #
            # types = types.map do |type|
            #   seq = node.shapeshift(:seq)
            #   seq.types.replace([type])
            #   [seq, type]
            # end.flatten

            any = node.shapeshift(:any)
            return any if any.is?(:ref)

            # seqs = node.types.map do |type|
            #   node.shapeshift(:seq, types: [type.dup])
            # end
            # types = seqs + node.types
            types = [node, *node.types].map(&:dup)
            # p node.id

            any.types = types
            any.unset :aliases, :changes, :normal, :required, :unique

            any.types.each.with_index do |node, ix|
              node.unset :description, :summary, :title
              node.set :export, false if ix == 0
              node.set :normal, ix == 0 ? true : nil
              node.parent = any
            end

            # puts any.dump(mark: 'normal: true')

            any
          end
        end
      end
    end
  end
end
