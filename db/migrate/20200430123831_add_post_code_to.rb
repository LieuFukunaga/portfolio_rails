class AddPostCodeTo < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :postcode, :string, null: false
  end
end
