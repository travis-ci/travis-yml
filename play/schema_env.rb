require 'json-schema'

schema = File.read('spec.draft.env.json')
schema = <<~json
{
  "definitions": {
    "env_var": {
      "anyOf": [
        {
          "type": "string",
          "pattern": "^[^=]+=[^=]+$"
        },
        {
          "type": "object",
          "properties": {
            "secure": {
              "type": "string"
            }
          },
          "additionalProperties": false
        },
        {
          "type": "object",
          "patternProperties": {
            ".*": { "type": "string" }
          },
          "additionalProperties": false
        }
      ]
    },
    "env_vars": {
      "anyOf": [
        {
          "$ref": "#/definitions/env_var"
        },
        {
          "type": "array",
          "items": {
            "$ref": "#/definitions/env_var"
          }
        },
        {
          "type": "object",
          "patternProperties": {
            ".*": { "type": "string" }
          },
          "additionalProperties": false
        }
      ]
    }
  },
  "type": "object",
  "properties": {
    "env": {
      "anyOf": [
        {
          "type": "object",
          "properties": {
            "global": {
              "$ref": "#/definitions/env_vars"
            },
            "matrix": {
              "$ref": "#/definitions/env_vars"
            }
          },
          "additionalProperties": false
        },
        {
          "$ref": "#/definitions/env_vars"
        }
      ]
    }
  },
  "additionalProperties": false
}
json
puts schema
puts

valid = [
  { "env": "FOO=foo" },
  { "env": { "secure": "1234" } },
  { "env": { "FOO": "foo" } },
  { "env": [ "FOO=foo" ] },
  { "env": [ "FOO=foo", { "BAR": "bar" }, { "secure": "1234" }] },

  { "env": { "matrix": "FOO=foo" } },
  { "env": { "matrix": ["FOO=foo"] } },
  { "env": { "matrix": { "FOO": "foo" } } },
  { "env": { "matrix": { "secure": "1234" } } },
  { "env": { "matrix": [ "FOO=foo", { "BAR": "bar" }, { "secure": "1234" } ] } },

  { "env": { "global": "FOO=foo" } },
  { "env": { "global": [ "FOO=foo" ] } },
  { "env": { "global": { "FOO": "foo" } } },
  { "env": { "global": { "secure": "1234" } } },
  { "env": { "global": [ "FOO=foo", { "BAR": "bar" }, { "secure": "1234" } ] } },
]

invalid = [
  { "env": "FOO" },
  { "env": { "FOO": { "BAR": "bar" } } },
]

def validate(schema, configs)
  configs.each do |config|
    puts config
    msgs = JSON::Validator.fully_validate(schema, config, errors_as_objects: true)
    msgs = msgs.any? ? msgs.map { |msg| msg[:message] } : 'valid'
    puts msgs
    puts
  end
end

puts "SHOULD BE VALID\n\n"
validate(schema, valid)

puts "SHOULD BE INVALID\n\n"
validate(schema, invalid)
