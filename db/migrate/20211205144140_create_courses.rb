class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :user_id
      t.string :name
      t.string :prefecture
      t.integer :map_id
      t.text :introduction
      t.integer :image_id
      t.boolean :is_hid, default: false, null: false

      t.timestamps
    end
  end
end
