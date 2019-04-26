# frozen_string_literal: true
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
      module Type
        module Forms
          extend self

          # Applies certain well defined patterns to Maps and Seqs in order to
          # transform the given type to an Any with alternative forms.

          def apply(node)
            Node.expand(node)
          end

          class Node
            include Helper::Obj, Registry

            def self.expand(node)
              registered?(node.type) ? self[node.type].new.apply(node) : node
            end

            def expand(node)
              self.class.expand(node)
            end
          end

          class Map < Node
            register :map

            def apply(node)
              node = expand_map(node)
              node = expand_includes(node) if node.includes?
              other = includes(node) if node.includes?
              other = prefix(other || node, node[node.prefix], node.prefix) if node.prefix?
              other = enable(other || node) if node.change?(:enable)
              other = typed(other || node) if node.types.any?
              other || node
            end

            def expand_map(node)
              map = node.map { |key, node| [key, expand(node)] }.to_h
              node.mappings.replace(map)
              node
            end

            def expand_includes(node)
              includes = node.includes.map { |node| expand(node) }
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
              all = node.transform(:all)
              all.unset :prefix, :includes, :changes, :keys, :normal, :required, :unique
              all.types = [node, *node.includes]

              all.types.each.with_index do |node, ix|
                node.set :normal, nil
                node.set :export, false
                node.parent = all
              end

              all
            end

            # If the Map has a prefix we also accept the form of the schema
            # mapped with the prefix key. Therefore the Map gets expanded into
            # an Any with the same Map, and the schema mapped with the prefixed
            # key.
            #
            # E.g. if the prefixed key maps to a Str then we return an Any with
            # a Map and a Str:
            #
            #   map(foo: str) -> any(map(foo: str), str)
            #
            def prefix(node, child, prefix)
              any = node.transform(:any)
              any.types = [node, child]
              any.unset :prefix, :changes, :keys, :required, :unique

              child.example = node.examples[prefix]

              any.types.each.with_index do |node, ix|
                node.set :normal, ix == 0 ? true : nil
                node.set :export, false
                node.parent = any
              end

              any
            end

            # If the Map has a type (i.e. it is not strict) we also accept the
            # schema. Therefore the Map gets expanded into an Any with the same
            # Map, and the Map's schema.
            #
            # E.g. if the Map's schema is Str:
            #
            #   map(schema: str) -> any(map, str)
            #
            # This is useful e.g. for deploy providers that want to accept a
            # secure or a map with arbitrary keys that map to secures, like
            # Heroku.
            #
            def typed(node)
              any = node.transform(:any)
              any.types = [node, *node.types]
              any.unset :prefix, :changes, :keys, :normal, :required, :unique

              any.types.each.with_index do |node, ix|
                node.set :export, false
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
                any = node.transform(:any)
                any.types = [node]
                any.unset :changes, :keys
              end

              any.types << Bool.new(node.parent)

              any.types.each.with_index do |node, ix|
                node.set :normal, ix == 0 ? true : nil
                node.set :export, false
              end

              any
            end
          end

          class Schema < Map
            register :schema

            def includes(node)
              all = super(node.transform(:map))
              opts = { title: node.title, schema: all, expand_keys: node.expand_keys }
              Type::Schema.new(nil, opts)
            end
          end

          class Seq < Node
            register :seq
            register :strs

            def apply(node)
              type = detect(node, :str, :secure)
              return ref("#{type}s", node) if type
              node = expand_seq(node)
              node = wrap(node)
              node
            end

            def expand_seq(node)
              node.types.replace(node.map { |node| expand(node) })
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
            # If the first schema is an Any then this was just expanded from a
            # prefixed Map. In this case case want to use this Any's types to
            # replace the Seq's types.
            #
            # I.e. a Seq with an Any that has a Map and a Str needs to become
            # an Any with four types:
            #
            #   seq(map, str) -> any(seq(map), map, seq(str), str)
            #
            def wrap(node)
              types = [Str.new(node)] unless node.any?
              types ||= node.first.is?(:any) ? node.types.first.types : node.types

              types = types.map do |schema|
                seq = node.transform(:seq)
                seq.types.replace([schema])
                [seq, schema]
              end.flatten

              any = node.transform(:any)
              any.types = types
              any.unset :changes, :keys, :normal, :required, :unique

              any.each.with_index do |node, ix|
                node.set(:normal, ix == 0 ? true : nil)
                node.set(:export, false)
                node.parent = any
              end

              any
            end

            # For the predefined types :strs and :secures we can simply
            # return the reference to these.
            #
            def ref(id, node)
              opts = merge(node.opts, *node.types.map(&:opts))
              ref = node.transform(:ref, opts)
              ref.set :namespace, :type
              ref.set :id, id.to_sym
              ref
            end

            def detect(node, *types)
              types.detect { |type| all?(node, type) }
            end

            def all?(node, type)
              nodes = node.map { |node| node.ref? ? node.lookup : node }
              nodes.all?(&:"#{type}?") && node.id == :seq
              # ugh, srsly? find better conditions.
              # node.none?(&:enum?) &&
              # node.none?(&:vars?) &&
              # node.id != :strs &&
              # !node.support? &&
              # # !node.export? &&
              # true
            end
          end
        end
      end
    end
  end
end
