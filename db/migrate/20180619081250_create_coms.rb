class CreateComs < ActiveRecord::Migration[5.2]
  def change
    create_table :coms do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
