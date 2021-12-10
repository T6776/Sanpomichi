class CourseImage < ApplicationRecord
  attachment :image
  belongs_to :course
end
