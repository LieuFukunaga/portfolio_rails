class RemoveZipcodeFromAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :zipcode, :integer
  end
end
