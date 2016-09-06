class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :fullname
      t.boolean :gender
      t.boolean :is_admin
      t.string :avatar
      t.string :password_digest
      t.string :remember_digest

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
