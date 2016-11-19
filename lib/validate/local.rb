module Local
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'tmp/validate.sqlite'
  )

  ActiveRecord::Schema.define do
    create_table :requests do |t|
      t.integer :repository_id
      t.text :config
    end
  end unless ActiveRecord::Base.connection.data_source_exists?(:requests)

  ActiveRecord::Schema.define do
    create_table :msgs do |t|
      t.integer :repository_id
      t.integer :request_id
      t.text :msg
    end
  end unless ActiveRecord::Base.connection.data_source_exists?(:msgs)

  class Request < ActiveRecord::Base
    has_many :msgs
    serialize :config, JSON
  end

  class Msg < ActiveRecord::Base
    belongs_to :request
    serialize :msg, JSON
  end
end
