class DeleteHand < ActiveRecord::Migration[5.1]
  def change
    drop_table :hands
  end
end
