# 40024891, 40026448, 40035916, 40036679, 40037160, 40042547, 40047533, 40048151, 40048502, 40049239, 40049501, 4004996

require 'active_record'
require 'json'
require 'faraday'
require 'fileutils'

Repository = Class.new(ActiveRecord::Base)
Request = Class.new(ActiveRecord::Base)
puts 'Connecting to remote db ...'
ActiveRecord::Base.establish_connection
puts 'Connection established.'

def repo_for(request_id)
  request = Request.select(:repository_id).find(request_id)
  Repository.select(:id, :owner_name, :name).find(request.repository_id)
end

def slug_from(repo)
  [repo.owner_name, repo.name].join('/')
end

def http
  Faraday.new(url: 'https://api.github.com/') do |c|
    c.response :raise_error
    c.adapter  :net_http
  end
end

def fetch(request_id)
  repo = repo_for(request_id)
  slug = slug_from(repo)
  puts "Storing .travis.yml from #{slug} ..."

  response = http.get("repos/#{slug}/contents/.travis.yml")
  body = JSON.parse(response.body)
  content = body['content'].to_s.unpack('m').first
  path = "spec/fixtures/repos/#{slug[0].downcase}/#{slug.sub('/', '_')}.yml"

  FileUtils.mkdir_p(File.dirname(path))
  File.write(path, content)
end

ids = ARGV
ids.each { |id| fetch(id) }
