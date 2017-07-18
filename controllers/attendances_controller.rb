require "date"

class Public < Sinatra::Base
  get '/attendances' do
    @attendances_users = Attendance.where(
      record_time: Date.today..Date.tomorrow, 
      status: 0
    ).map(&:user).select{ |user| user.attendances.last.status == "enter" }
    haml :"attendances/index"
  end

  post '/attendance/user' do
    params = JSON.parse(request.body.read)
    if user = User.find_by(idm: params["idm"])
      else
    end
  end
end

class Protect < Sinatra::Base

  # 出席のキャンセル
  post '/attendances/cancel' do
    params = JSON.parse(request.body.read)
    attendance = User.find_by(
      idm: params["idm"]
    ).attendances.where(
      record_time: Date.today..Date.tomorrow, 
      status: "left"
    )
    unless attendance.empty?
      attendance[0].destroy
      {status: "OK"}.to_json
    else
      {stauts: "NG"}.to_json
    end
  end

  # 出席の登録
  post '/attendances/create' do
    params =  JSON.parse(request.body.read)
    user = User.find_by(idm: params["idm"])
    binding.pry
    status = judge(user)
    attendance = Attendance.new(
      user: user,
      record_time: Time.parse(params["datetime"]),
      status: status
    )
    if Attendance.where(user: user, record_time: Date.today..Date.tomorrow, status: 1).exists?
      {stauts: "already"}.to_json
    elsif user.attendances.last && (user.attendances.last.record_time + 1.minute) > Time.now
      {status: "early"}.to_json
    else
      p attendance if settings.development?
      if attendance.save
        {stauts: attendance.status}.to_json
      else
        {stauts: "error"}.to_json
      end
    end
  end

  private

  def judge(user)
    # 0 => enter, 1 => left
    unless user.attendances.last
      return 0
    else
      if Date.today > user.attendances.last.record_time
        return 0
      else
        case user.attendances.last.status
        when "enter" then
          return 1
        when "left" then
          return 0
        else 
          return 0
        end
      end
    end
  end

end
