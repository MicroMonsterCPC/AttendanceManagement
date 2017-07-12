require 'bundler/setup'
Bundler.require

config  = YAML.load_file( './database.yml' )
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config["development"])

after do
  ActiveRecord::Base.connection.close
end

class User < ActiveRecord::Base 
end
