require "sinatra"
require "sinatra/reloader"
require "json"
require "./models"
require "./controllers/users_controller"

# HOME 
get '/' do
  "HelloWorld"
end

# Attendance management
post '/attendance-record' do
  params =  JSON.parse(request.body.read)
  user = User.find_by(uuid: params["uuid"])
end
