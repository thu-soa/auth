class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :user_type
      t.timestamps null: false
    end
  end
end
