class CreateHands < ActiveRecord::Migration[5.1]
  def change
    create_table :hands do |t|
      t.text :content

      t.timestamps
    end
  end
end
