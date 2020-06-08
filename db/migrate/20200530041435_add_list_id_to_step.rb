class AddListIdToStep < ActiveRecord::Migration[5.2]
  def change
    add_reference :steps, :list, foreign_key: true
  end
end
