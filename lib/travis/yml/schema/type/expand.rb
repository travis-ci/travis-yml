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
        module Expand
          extend self

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
              other = prefix(other || node, node[node.prefix]) if node.prefix?
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

            def includes(node)
              all = node.transform(:all)
              all.unset :prefix, :includes, :changes, :keys, :normal, :required, :unique
              all.schemas = [node, *node.includes]

              all.schemas.each.with_index do |node, ix|
                node.set(:normal, nil)
                node.set(:export, false)
                node.parent = all
              end

              all
            end

            def prefix(node, child)
              any = node.transform(:any)
              any.schemas = [node, child]
              any.unset :prefix, :changes, :keys, :normal, :required, :unique

              any.schemas.each.with_index do |node, ix|
                node.set(:normal, ix == 0 ? true : nil)
                node.set(:export, false)
                node.parent = any
              end

              any
            end
          end

          class Schema < Map
            register :schema

            def includes(node)
              all = super(node.transform(:map))
              opts = { title: node.title, schema: all, expand: node.expand }
              Type::Schema.new(nil, opts)
            end
          end

          class Seq < Node
            register :seq

            def apply(node)
              type = detect(node, :str, :secure)
              type ? ref("#{type}s", node) : wrap(node)
            end

            def wrap(node)
              any = node.transform(:any)
              any.schemas = [node, *node.map { |node| expand(node) }]
              any.unset :changes, :keys, :normal, :required, :unique

              any.each.with_index do |node, ix|
                node.set(:normal, ix == 0 ? true : nil)
                node.set(:export, false)
                node.parent = any
              end

              any
            end

            def ref(ref, node)
              ref = node.transform(:ref, ref: ref)
              ref.set :namespace, node.namespace # ??
              ref
            end

            def detect(node, *types)
              types.detect { |type| all?(node, type) }
            end

            def all?(node, type)
              node.all?(&:"#{type}?") && node.none?(&:enum?) && node.none?(&:vars?)
            end
          end
        end
      end
    end
  end
end
