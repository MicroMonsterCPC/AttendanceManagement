alias dc="docker-compose"

dc build
dc run web bundle install -j4 --path vendor/bundle
dc run web bundle exec rake db:create
dc run web bundle exec rake db:migrate

dc up

