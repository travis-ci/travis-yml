class CreateConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :configs do |t|
      t.integer  :build_id
      t.text     :original_config
      t.jsonb    :parsed_config
      t.integer  :repo_id
      t.string   :owner_type
      t.integer  :owner_id
    end

    create_table :messages do |t|
      t.string   :level
      t.string   :key
      t.string   :code
      t.text     :args
      t.integer  :config_id
    end
  end
end
