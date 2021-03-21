require 'mysql2'
require 'active_record'

#ActiveRecord::Base.establish_connection(
#  adapter: 'mysql2',
#  host: 'localhost',
#  username: 'antuan',
#  password: 'nautna',
#  database: 'atpay'
#)

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'test.db')

class CreatePaymentTable < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |table|
      table.string :name
      table.integer :amount
      table.string :confirmation
      table.string :bill_uuid
      table.date :date
      table.timestamps
    end
  end
end

# Create the table
CreatePaymentTable.migrate(:up)

# Drop the table
#CreateUserTable.migrate(:down)
