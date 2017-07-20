class Public < Sinatra::Base
  configure do
    set :public_folder, '/app/public'
    set :views, '/app/views'
  end
end
class Protect < Sinatra::Base
  configure do
    set :public_folder, '/app/public'
    set :views, '/app/views'
  end
end
