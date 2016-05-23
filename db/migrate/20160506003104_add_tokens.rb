class AddTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string  :token_string
      t.integer :user_id
      t.timestamp null: false
    end
  end
end
