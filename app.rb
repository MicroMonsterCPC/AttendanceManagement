require "sinatra"
require "sinatra/base"
require "sinatra/reloader"
require "pry"
require "json"
require "./models"
require './config/config'
require "./controllers/users_controller"
require "./controllers/attendances_controller"

not_found do
  {error: 404}.to_json
end

class Public < Sinatra::Base
  # HOME 
  get '/' do
    "HelloWorld"
  end
end

class Protect < Sinatra::Base
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    if settings.development?
      username == 'foo' && password == 'bar'
    else
      username == ENV.fetch('BASIC_USER') && password == ENV.fetch('BASIC_PASS')
    end
  end
  get "/" do
    "secret page!"
  end
  get "/admin" do
    "admin"
  end
end
