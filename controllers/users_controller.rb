# index
get '/users' do
  @users = User.all
  haml :"users/index"
end

# show
get '/users/:id/show' do
  @user = User.find_by(id: params[:id])
  haml :"users/show"
end

# new
get '/users/new' do
  @user = User.new
  haml :"users/new"
end

post '/users/create' do
  user = User.new({name: params[:name], uuid: params[:uuid]})
  if user.save
    @mes = "Success: User Created"
  else
    @mes = "Failure: User Created"
  end
  haml :"assets/message"
end

# edit
get '/users/:id/edit' do
  @user = User.find_by(id: params[:id])
  haml :"usres/new"
end

# update
put '/users/:id' do
  user = User.find_by(id: params[:id])
  if user.update( name: params[:name], uuid: params[:uuid])
    @mes = "Success: User Update"
  else
    @mes = "Failure: User Update"
  end
  haml :"assets/message"
end

# delete
delete '/users/:id' do
  if User.find_by(id: params[:id]).destory
    @mes = "Success: User Delete"
  else
    @mes = "Failure: User Delete"
  end
  haml :"assets/message"
end
