class CreateCourseImages < ActiveRecord::Migration[5.2]
  def change
    create_table :course_images do |t|
      t.integer :course_id
      t.string :image_id

      t.timestamps
    end
  end
end
