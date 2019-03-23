# {
#   "type": "object",
#   "properties": {
#     "foo": { "enum": ["bar", "baz"] },
#     "bar": { "type": "string" },
#     "baz": { "type": "string" }
#   },
#   "anyOf": [
#     {
#       "properties": {
#         "foo": { "enum": ["bar"] }
#       },
#       "required": ["bar"]
#     },
#     {
#       "properties": {
#         "foo": { "enum": ["baz"] }
#       },
#       "required": ["baz"]
#     }
#   ]
# }

require 'json-schema'

spec = {
  definitions: {
    language: {
      type: 'object',
      properties: {
        lang: { enum: ['ruby', 'java'] },
        ruby: { type: 'string' },
        java: { type: 'string' }
      },
      anyOf: [
        {
          properties: {
            lang: { enum: ['ruby'] },
            ruby: { type: 'string' }
          },
          additionalProperties: false
        },
        {
          properties: {
            lang: { enum: ['java'] },
            java: { type: 'string' }
          },
          additionalProperties: false
        }
      ],
    }
  },
  anyOf: [
    { '$ref': '#/definitions/language' }
  ]
}
puts JSON.pretty_generate(spec)

def validate(schema, config)
  schema = JSON.load(JSON.dump(schema))
  config = JSON.load(JSON.dump(config))
  puts config
  msgs = JSON::Validator.fully_validate(schema, config, errors_as_objects: true)
  msgs = msgs.any? ? msgs.map { |msg| msg[:message] } : 'valid'
  puts msgs
end

config = {
  lang: 'ruby',
}
validate(spec, config)

config = {
  lang: 'java',
}
validate(spec, config)

config = {
  lang: 'ruby',
  ruby: '2.2.2',
}
validate(spec, config)

config = {
  lang: 'java',
  java: '8',
}
validate(spec, config)

config = {
  lang: 'ruby',
  ruby: '2.2.2',
  java: '8'
}
validate(spec, config)
