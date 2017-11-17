class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.string :writter

      t.timestamps null: false
    end
  end
end
