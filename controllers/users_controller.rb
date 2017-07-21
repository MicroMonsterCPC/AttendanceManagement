# index
class Public < Sinatra::Base
  get '/users' do
    @users = User.all
    haml :"users/index"
  end

  # show
  get '/users/:id/show' do
    # 出席日数 / 出席必要日数 * 100
    @user = User.find_by(id: params["id"])
    user_attendances = @user.attendances

    @attendance_status = []
    user_attendances.each do |attendance|
      @attendance_status << attendance.status_before_type_cast
    end

    @attendance_dates = user_attendances.map(&:record_time).map(&:to_s)
    @attendance_rate = @user.attendances.where(status: "enter").count / ENV.fetch('REQUIRE_DAYS').to_f * 100
    haml :"users/show"
  end

  # idmの登録を確認
  post '/users/exists' do
    params =  JSON.parse(request.body.read)
    result = User.where(idm: params["idm"]).exists?
    {result: result}.to_json
  end

end

class Protect < Sinatra::Base
  # new
  get '/users/new' do
    @form_action = "/protect/users/create"
    @submit_title = "Create"
    @user = User.new
    haml :"users/new"
  end

  post '/users/create' do
    user = User.new({name: params[:name], idm: params[:idm]})
    if user.save
      p user
      @mes = "Success: User Created"
    else
      @mes = "Failure: User Created"
    end
    haml :"assets/message"
  end

  # edit
  get '/users/:id/edit' do
    @form_action= "/protect/users/#{params[:id]}/update"
    @submit_title = "Update"
    @user = User.find_by(id: params[:id])
    haml :"users/new"
  end

  # update
  post '/users/:id/update' do
    user = User.find_by(id: params[:id])
    if user.update( name: params[:name], idm: params[:idm])
      @mes = "Success: User Update"
    else
      @mes = "Failure: User Update"
    end
    haml :"assets/message"
  end

  # delete
  get '/users/:id/delete' do
    if User.find_by(id: params[:id]).destory
      @mes = "Success: User Delete"
    else
      @mes = "Failure: User Delete"
    end
    haml :"assets/message"
  end
end
