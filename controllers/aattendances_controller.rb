class Public < Sinatra::Base
  # idmの登録を確認
  post '/is-exists-idm' do
    params =  JSON.parse(request.body.read)
    result = User.where(idm: params["idm"]).exists?
    {result: result}.to_json
  end
end

class Protect < Sinatra::Base
  # Attendance management
  post '/attendance-record' do
    params =  JSON.parse(request.body.read)
    user = User.find_by(idm: params["idm"])
    Attendance.new(
      user: user,
      record_time: params["datetime"],
      status: judge(user)
    )
  end
  private

  def judge(user)
    case user.attendances.last.status
    when 0 then
      return 1
    when 1 then
      return 0
    end
  end

end
