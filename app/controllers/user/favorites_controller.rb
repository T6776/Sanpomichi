class User::FavoritesController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    @favorite = current_user.favorites.new(course_id: @course.id)
    @favorite.save
  end

  def destroy
    @course = Course.find(params[:course_id])
    @favorite = current_user.favorites.find_by(course_id: @course.id)
    @favorite.destroy
  end
end
