require 'travis/yml/web'

Travis::Yml.setup

run Travis::Yml::Web::App.new
