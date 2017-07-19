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
    users = User.where(idm: params["idm"])
    users.each do |user|
      status = judge(user)
      attendance = Attendance.new( user: user, record_time: Time.parse(params["datetime"]), status: status)
      (return {status: "already"}.to_json) if Attendance.where(user: user, record_time: Date.today..Date.tomorrow, status: 1).exists?
      (return {status: "early"}.to_json)   if user.attendances.last && (user.attendances.last.record_time + 1.minute) > Time.now
      attendance.save ? ( return {status: attendance.status}.to_json) : (return {status: "Error"})
    end
    {status: "nouser"}.to_json
  end

  private

  def judge(user)
    # 0 => enter, 1 => left
      binding.pry
    unless user.attendances.last
      return 0
    else
      if Date.today.to_time > user.attendances.last.record_time
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
