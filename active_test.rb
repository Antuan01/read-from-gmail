require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'antuan',
  password: 'nautna',
  database: 'atpay'
)

class Payment < ActiveRecord::Base
  self.table_name = 'users'
  self.primary_key = 'user_id'
end


