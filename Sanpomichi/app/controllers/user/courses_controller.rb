class User::CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
    ## マイマップidを抜き出してiframe内のURLに渡す
    map = @course.map_id
    map.slice!(0..42)
    @map = map.first(33)
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    @course.save
    redirect_to courses_path
  end

  def update
  end

  def delete
  end

  def course_params
    params.require(:course).permit(:name, :prefecture, :map_id, :introduction, :image_id, :is_hid)
  end
end
