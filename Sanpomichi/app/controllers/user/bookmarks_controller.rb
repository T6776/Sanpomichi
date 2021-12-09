class User::BookmarksController < ApplicationController
  def index
  end

  def create
    @course = Course.find(params[:course_id])
    @bookmark = current_user.bookmarks.new(course_id: @course.id)
    @bookmark.save
    redirect_to course_path(@course)
  end

  def destroy
    @course = Course.find(params[:course_id])
    @bookmark = current_user.bookmarks.find_by(course_id: @course.id)
    @bookmark.destroy
    redirect_to course_path(@course)
  end
end
