class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.integer :status, limit: 1, default: 0
      t.references :list, foreign_key: true
      t.timestamps
    end
  end
end
