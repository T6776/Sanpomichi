class RemoveMapIdFromCourses < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :map_id, :integer
  end
end
