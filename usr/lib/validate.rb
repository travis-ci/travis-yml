# frozen_string_literal: true
require 'active_record'
require 'json'
require 'yaml'
require 'optparse'
require 'travis/yaml'
require 'validate/check'
require 'validate/export'
require 'validate/inspect'
require 'validate/local'
require 'validate/report'
require 'validate/review'

$stdout.sync = true

opts = {
  from:  45_000_000,
  # count: 10_000_000,
  count:  2_500_000,
  clean: false,
}

OptionParser.new do |o|
  o.on '--from ID', 'Request id to start at' do |value|
    opts[:from] = value.to_i
  end

  o.on '--count ID', 'Number of requests to fetch' do |value|
    opts[:count] = value.to_i
  end

  o.on '--counts', 'Counts' do
    opts[:counts] = true
  end

  o.on '--details', 'Details' do
    opts[:details] = true
  end

  o.on '--clean', 'Cleanup previous results' do
    opts[:clean] = true
  end
end.parse!

case ARGV.shift || 'summary'
when 'fetch'
  require 'validate/fetch'
  Fetch.new(opts[:from], opts[:count]).run
when 'check'
  ids = ARGF.read unless $stdin.tty?
  ids = ids.split("\n").map(&:strip).reject { |id| id =~ /[^0-9]/ } if ids
  ids ||= ARGV
  Check.new(opts.merge(ids: ids)).run
when 'report'
  Report.new(opts.merge(ids: ARGV)).run
when 'export'
  Export.new(codes: ARGV).run
when 'inspect'
  Inspect.new(code: ARGV.shift.gsub(/\W/, ''), str: ARGV.join(' ')).run
when 'import'
  Import.new.run
when 'review'
  Review.new.run
else
  puts 'Unknown command'
end
