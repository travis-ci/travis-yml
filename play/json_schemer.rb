require 'json'
require 'yaml'
require 'json-schema'
# require 'json_schemer'
require 'travis/yml'
require 'neatjson'

# schema = File.read('schema.json')
spec = Travis::Yml.spec
# spec = spec.merge(
#   anyOf: [
#     {
#       type: 'object',
#       properties: {
#         language: { '$ref': '#/definitions/language' }
#       },
#       additionalProperties: false
#     }
#   ]
# )
puts JSON.neat_generate(spec, wrap: true)
p JSON::Validator.validate(JSON.dump(spec), {}, validate_schema: true)

# spec = {
#   type: 'object',
#   properties: {
#     "a" => {"type" => "integer"}
#   }
# }

config = YAML.load <<~yml
  language: ruby
yml

# p JSONSchemer.schema(JSON.dump(spec)).valid?(config, strict: true)

# p JSON::Validator.validate(JSON.dump(spec), config)

# p schemer.valid? YAML.load <<~yml
#   language: ruby
#   rvm: 2.5.0
# yml
