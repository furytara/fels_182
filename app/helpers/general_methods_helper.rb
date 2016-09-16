module GeneralMethodsHelper
  def require_logged_in_user
    unless logged_in?
      flash[:danger] = t "require_logged_in"
      redirect_to root_path
    end
  end

  def require_logged_in_as_admin
    unless current_user.is_admin?
      log_out
      redirect_to root_path
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user.is_user? current_user
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "Nil_user"
      redirect_to root_url
    end
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.nil?
      flash[:danger] = t "Nil_lesson"
      redirect_to root_url
    end
  end
end
