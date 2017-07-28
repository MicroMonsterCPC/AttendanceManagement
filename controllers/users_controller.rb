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

    @attendance_dates, @attendance_status, @attendance_status_1month_ago = [], [], []

    ((Date.today - 28.days)..(Date.today)).each do |date|
      @attendance_dates << date.to_time.strftime("%d日")
      unless user_attendances.empty?
        @attendance_status << ( attendances_status(user_attendances, date) ? 1 : 0 )
        @attendance_status_1month_ago << (attendances_status(user_attendances, date << 1) ? 1 : 0 )
      end
    end

    @attendance_rate = (user_attendances.where(status: "enter").count / ENV.fetch('REQUIRE_DAYS').to_f * 100)
    haml :"users/show"
  end

  private

  def attendances_status(user_attendances, date)
    unless user_attendances.where(record_time: ((date.to_time)..(date + 1.days).to_time)).empty?
      return true
    else
      return false
    end
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
    if User.find_by(id: params[:id]).destroy!
      @mes = "Success: User Delete"
    else
      @mes = "Failure: User Delete"
    end
    haml :"assets/message"
  end
end
