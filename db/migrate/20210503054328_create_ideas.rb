class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.text :body, null: false
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end
  end
end
