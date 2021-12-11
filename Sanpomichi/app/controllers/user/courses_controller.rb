class User::CoursesController < ApplicationController
  def index
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @courses = @tag.courses.order(created_at: :desc)
    else
      @courses = Course.all
    end
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
    @comment = Comment.new
    ## 保存されたURLからマイマップidを抜き出してiframe内のURLに渡す
    map = @course.map_id
    map.slice!(0..42)
    @map = map.first(33)
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    @course.save
    redirect_to courses_path
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to course_path(@course)
    else
      render :edit
    end
  end

  def delete
  end

  def bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def course_params
    values = params.require(:course).permit(:name, :course_id, :prefecture, :map_id, :introduction, :is_hid, course_images_images: [], tag_ids: [] )
    if values[:tag_ids].nil?
      values[:tag_ids] = []
    end
    return values
  end
end
