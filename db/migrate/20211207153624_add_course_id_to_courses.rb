class AddCourseIdToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :course_id, :integer
  end
end
