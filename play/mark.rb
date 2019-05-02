class String
  attr_accessor :wat
end

key = 'key'
key.wat = 1

value = 'value'
value.wat = 2

hash = { key => value }

p [hash.keys.first, hash.keys.first.wat, key.wat]
p [hash.values.first, hash.values.first.wat, value.wat]

# outputs:
#
#   ["key", nil, 1]
#   ["value", 2, 2]

hash = { 'key' => 'value' }
hash.keys.first.wat = 1

# throws:
#
#   can't modify frozen String (FrozenError)
