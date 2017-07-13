require 'bundler/setup'
Bundler.require

config  = YAML.load_file( './database.yml' )
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config["development"])

after do
  ActiveRecord::Base.connection.close
end

class User < ActiveRecord::Base 
  has_many :attendances
  validates :idm, presence: true, uniqueness: true
end

class Attendance < ActiveRecord::Base
  belongs_to :user
  enum status: {enter: 0, left: 1}
end
