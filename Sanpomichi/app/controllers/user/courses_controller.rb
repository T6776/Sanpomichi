class User::CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
    ## URLからマイマップidを抜き出してiframe内のURLに渡す
    map = @course.map_id
    map.slice!(0..42)
    @map = map.first(33)
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    @course.save
    redirect_to courses_path
  end

  def update
  end

  def delete
  end

  def course_params
    values = params.require(:course).permit(:name, :course_id, :prefecture, :map_id, :introduction, :image_id, :is_hid, tag_ids: [] )
    if values[:tag_ids].nil?
      values[:tag_ids] = []
    end
    return values
  end
end
