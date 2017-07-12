# index
get '/users' do
  @users = User.all
  load_template("users/index")
end

# show
get '/users/:id' do
  @user = User.find_by(id: params[:id])
  load_template("users/show")
end

# new
get '/users/new' do
  @user = User.new
  load_template("usres/new")
end

post '/users/create' do
  user = User.new{name: params[:name], uuid: params[:uuid]}
  if user.save
    @mes = "Success: User Created"
    else
    @mes = "Failure: User Created"
  end
  load_template("assets/message")
end

# edit
put '/users/:id/edit' do
  @user = User.find_by(id: params[:id])
  load_template("usres/new")
end

# update
put '/users/:id' do
  user = User.find_by(id: params[:id])
  if user.update( name: params[:name], uuid: params[:uuid])
    @mes = "Success: User Update"
  else
    @mes = "Failure: User Update"
  end
  load_template("assets/message")
end

# delete
delete '/users/:id' do
  if User.find_by(id: params[:id]).destory
    @mes = "Success: User Delete"
  else
    @mes = "Failure: User Delete"
  end
  load_template("assets/message")
end

private

def load_template(view_file)
  erb :"#{view_file}", layout: :"layout/layout"
end
