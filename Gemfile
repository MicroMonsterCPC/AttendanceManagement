source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem "rake"
gem "sinatra"
gem "sinatra-contrib"
gem "sinatra-activerecord"

gem "haml"

gem 'pg', '~> 0.18'


group :development, :test do
  gem "pry"
  gem "pry-byebug"
end
