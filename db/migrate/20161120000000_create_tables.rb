class CreateTables < ActiveRecord::Migration[4.2]
  def self.up
    create_table :repos do |t|
      t.string :owner_name
      t.string :name
    end

    create_table :requests do |t|
      t.integer :repo_id
      t.text    :config
      t.boolean :checked
    end

    create_table :messages do |t|
      t.integer :repo_id
      t.integer :request_id
      t.string  :level
      t.string  :key
      t.string  :code
      t.text    :args
      t.timestamp :created_at
    end

    create_table :reviews do |t|
      t.integer :message_id
      t.string  :name
      t.string  :status
      t.text    :message
      t.timestamp :created_at
    end
  end

  def self.down
    drop_table :repos
    drop_table :requests
    drop_table :messages
    drop_table :reviews
  end
end
