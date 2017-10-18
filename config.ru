require 'rack/ssl-enforcer'
require 'travis/yaml/web'
require 'travis/yaml/web/basic_auth'
require 'travis/yaml/web/env'
use Rack::SslEnforcer if Travis::Yaml::Web::Env.production?
use Travis::Yaml::Web::BasicAuth
run Travis::Yaml::Web
