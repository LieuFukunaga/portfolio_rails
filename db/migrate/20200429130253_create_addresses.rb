class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :zipcode
      t.text :address
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
