class AddTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string  :token_string
      t.integer :user_id
      t.datetime :valid_until
      t.timestamp null: false
    end
  end
end
