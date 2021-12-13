class RemoveImageIdFromCourse < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :image_id, :string
  end
end
