class User::CoursesController < ApplicationController
  def index
    @tags = Tag.all
    ## 公開設定されているコースのみを取得
    courses = Course.where(is_hid: false)
    ## 検索欄で選択した都道府県のコースを取得
    courses = Course.where(prefecture: params[:prefecture]).where(is_hid: false) if params[:prefecture].present?
    ## 検索欄で選択した都道府県＋選択したタグのコースを取得
    if params[:tag_name].present?
      ## タグに紐づいてる中間テーブルcourse_tagを取得
      tagid = Tag.where(name: params[:tag_name])
      coursetags = CourseTag.where(tag_id: tagid)
      ## 中間テーブルに紐づいているコースのidを取得
      courseid = coursetags.pluck(:course_id)
      ## idが重複しているコースのみ抜き出す(複数タグのand検索)
      courseid2 = courseid.select{|v| courseid.count(v) > (params[:tag_name].size - 1) }.uniq
      courses = Course.where(id: courseid2).where(prefecture: params[:prefecture]).where(is_hid: false)
    end
    ## ソート処理
    if params[:sort] == "old"
      @courses = courses.order(:created_at)
    elsif params[:sort] == "favorite"
      ## favoritesテーブルに外部結合し、同じコースに紐づいているものをまとめ、その数で並び替え
      @courses = courses.left_joins(:favorites).group("courses.id").order("count(favorites.id) desc")
    else
      @courses = courses.order(created_at: "DESC")
    end
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
    ## 非公開設定がされている場合、作成ユーザー以外はコース一覧にリダイレクトする
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
    @tags = Tag.all
    courses = Course.where(user_id: current_user.id)
    courses = Course.where(prefecture: params[:prefecture]).where(user_id: current_user.id) if params[:prefecture].present?
    if params[:tag_name].present?
      tagid = Tag.where(name: params[:tag_name])
      coursetags = CourseTag.where(tag_id: tagid)
      courseid = coursetags.pluck(:course_id)
      courseid2 = courseid.select{|v| courseid.count(v) > (params[:tag_name].size - 1) }.uniq
      courses = Course.where(id: courseid2).where(prefecture: params[:prefecture]).where(user_id: current_user.id)
    end
    if params[:sort] == "old"
      @courses = courses.order(:created_at)
    elsif params[:sort] == "favorite"
      @courses = courses.left_joins(:favorites).group("courses.id").order("count(favorites.id) desc")
    else
      @courses = courses.order(created_at: "DESC")
    end
  end

  def bookmark
    @tags = Tag.all
    bookmark = Bookmark.where(user_id: current_user.id)
    bmcourseid = bookmark.pluck(:course_id)
    courses = Course.where(id: bmcourseid)
    courses = Course.where(prefecture: params[:prefecture]).where(id: bmcourseid) if params[:prefecture].present?
    if params[:tag_name].present?
      tagid = Tag.where(name: params[:tag_name])
      coursetags = CourseTag.where(tag_id: tagid)
      courseid = coursetags.pluck(:course_id)
      courseid2 = courseid.select{|v| courseid.count(v) > (params[:tag_name].size - 1) }.uniq
      courses = Course.where(id: courseid2).where(prefecture: params[:prefecture]).where(id: bmcourseid)
    end
    if params[:sort] == "old"
      @courses = courses.order(:created_at)
    elsif params[:sort] == "favorite"
      @courses = courses.left_joins(:favorites).group("courses.id").order("count(favorites.id) desc")
    else
      @courses = courses.order(created_at: "DESC")
    end
  end

  private

  def course_params
    values = params.require(:course).permit(:name, :course_id, :prefecture, :map_id, :introduction, :is_hid, course_images_images: [], tag_ids: [] )
    if values[:tag_ids].nil?
      values[:tag_ids] = []
    end
    return values
  end

  def sort_params
    params.permit(:sort)
  end
end
