web: bundle exec puma -C checker/config/puma.rb
sidekiq: bundle exec sidekiq -e ${RACK_ENV:-development} -r ./checker/config/sidekiq.rb -q yml
console: bundle exec irb -I checker -r app.rb
