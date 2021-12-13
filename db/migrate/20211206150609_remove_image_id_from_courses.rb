class RemoveImageIdFromCourses < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :image_id, :integer
  end
end
