class AddDateToGoals < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :date, :datetime
  end
end
