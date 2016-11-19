require 'active_record'
require 'sqlite3'
require 'json'
require 'yaml'
require 'optparse'
require 'travis/yaml'
require 'validate/check'
require 'validate/summary'

$stdout.sync = true

OK = [
  :empty_config,
  :edge,
  :flagged,
]

OK_ISH = [
  :empty
]

DETAILS = [
  :invalid_type,
  :invalid_seq,
  :empty,
  :unknown_value,
  :unknown_key,
  :cast,
  :unsupported,
  :invalid_format,
  :required,
  :unknown_default,
  :parse_error,
  :unknown_var
]

opts = {
  details: [],
  from: 41_000_000,
  count: 1_000_000,
}

OptionParser.new do |o|
  o.on '--from ID', 'Request id to start at' do |value|
    opts[:from] = value.to_i
  end

  o.on '--count ID', 'Number of requests to fetch' do |value|
    opts[:count] = value.to_i
  end

  o.on '--details DETAILS', 'Details' do |value|
    opts[:details] = value.split(',').map(&:to_sym)
  end
end.parse!

opts[:details] = DETAILS if opts[:details] == [:all]

case ARGV.shift || 'summary'
when 'fetch'
  require 'validate/fetch'
  Fetch.new(opts[:from], opts[:count]).run
when 'check'
  Check.new(ids: ARGV).run
when 'summary'
  Summary.new(opts.merge(ids: ARGV)).run
end
