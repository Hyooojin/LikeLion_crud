class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :instauser_id
      t.string :image_url
      t.string :content
      

      t.timestamps null: false
    end
  end
end
