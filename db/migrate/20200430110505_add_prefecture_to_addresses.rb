class AddPrefectureToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :prefecture, :integer, default: 0, limit: 1
    add_column :addresses, :city,       :string, null: false
    add_column :addresses, :building,   :string
  end
end
