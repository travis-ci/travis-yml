# describe Travis::Yml::Schema::Def::Language do
#   subject { Travis::Yml.schema[:definitions][:type][:language] }
#
#   # it { puts JSON.pretty_generate(subject) }
#
#   it do
#     should eq(
#       '$id': :language,
#       title: 'Language',
#       type: :string,
#       enum: [
#         'android',
#         'c',
#         'clojure',
#         'cpp',
#         'crystal',
#         'csharp',
#         'd',
#         'dart',
#         'elixir',
#         'elm',
#         'erlang',
#         'go',
#         'groovy',
#         'haskell',
#         'haxe',
#         'java',
#         'julia',
#         'nix',
#         'node_js',
#         'objective-c',
#         'perl',
#         'perl6',
#         'php',
#         'python',
#         'r',
#         'ruby',
#         'rust',
#         'scala',
#         'shell',
#         'smalltalk',
#         '__connie__',
#         '__amethyst__',
#         '__garnet__',
#         '__stevonnie__',
#         '__opal__',
#         '__sardonyx__',
#         '__onion__',
#         '__cookiecat__'
#       ],
#       downcase: true,
#       defaults: [
#         {
#           value: 'ruby',
#           only: {
#             os: [
#               'linux',
#               'windows'
#             ]
#           }
#         },
#         {
#           value: 'objective-c',
#           only: {
#             os: [
#               'osx'
#             ]
#           }
#         },
#       ],
#       values: {
#         cpp: {
#           aliases: [
#             'c++'
#           ]
#         },
#         go: {
#           aliases: [
#             'golang'
#           ]
#         },
#         java: {
#           aliases: [
#             'jvm'
#           ]
#         },
#         node_js: {
#           aliases: [
#             'javascript'
#           ]
#         },
#         'objective-c': {
#           aliases: [
#             'objective_c',
#             'swift'
#           ]
#         },
#         shell: {
#           aliases: [
#             'bash',
#             'generic',
#             'minimal'
#           ]
#         },
#         __connie__: {
#           deprecated: true
#         },
#         __amethyst__: {
#           deprecated: true
#         },
#         __garnet__: {
#           deprecated: true
#         },
#         __stevonnie__: {
#           deprecated: true
#         },
#         __opal__: {
#           deprecated: true
#         },
#         __sardonyx__: {
#           deprecated: true
#         },
#         __onion__: {
#           deprecated: true
#         },
#         __cookiecat__: {
#           deprecated: true
#         }
#       }
#     )
#   end
# end
