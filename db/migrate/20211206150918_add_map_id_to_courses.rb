class AddMapIdToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :map_id, :text
  end
end
