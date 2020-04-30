class AddTelNumToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tel_num, :string, null: false
  end
end
