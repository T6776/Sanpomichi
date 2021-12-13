class User::CoursesController < ApplicationController
  def index
    if params[:prefecture].present?
      @courses = Course.where(params[:prefecture])
    else
      ## 公開設定されているもののみ表示
      @courses = Course.where(is_hid: false)
    end
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
    ## 非公開設定がされている場合、作成ユーザー以外はコース一覧にリダイレクトさせる
    if @course.is_hid == true && @course.user != current_user
      respond_to do |format|
        format.html { redirect_to courses_path, notice: "非公開となっているコースです" }
      end
    end

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
    if @course.save
      redirect_to course_path(@course)
    else
      render :new
    end
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to course_path(@course)
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end

  def my_course
    @courses = Course.where(user_id: current_user.id)
  end

  def bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  private

  def course_params
    values = params.require(:course).permit(:name, :course_id, :prefecture, :map_id, :introduction, :is_hid, course_images_images: [], tag_ids: [] )
    if values[:tag_ids].nil?
      values[:tag_ids] = []
    end
    return values
  end

  def course_search_params
  end
end
