class User::FavoritesController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    @favorite = current_user.favorites.new(course_id: @course.id)
    @favorite.save
    redirect_to course_path(@course)
  end

  def destroy
    @course = Course.find(params[:course_id])
    @favorite = current_user.favorites.find_by(course_id: @course.id)
    @favorite.destroy
    redirect_to course_path(@course)
  end
end
