class User::CommentsController < ApplicationController
  def create
    course = Course.find(params[:course_id])
    comment = current_user.comments.new(comment_params)
    comment.course_id = course.id
    comment.save
    redirect_to course_path(course)
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    redirect_to course_path(params[:course_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
