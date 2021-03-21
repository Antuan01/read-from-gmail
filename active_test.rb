require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'test.db')

class Payment < ActiveRecord::Base
end

Payment.columns.each { |column|
  puts column.name
}

