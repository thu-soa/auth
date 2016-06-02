class AddPasswordMd5ToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_md5, :string
  end
end
