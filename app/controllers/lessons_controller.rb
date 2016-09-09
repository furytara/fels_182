class LessonsController < ApplicationController
  def create
    category = Category.find_by id: params[:category_id]
    @lesson = Lesson.new user: current_user, category: category
    if @lesson.save
      redirect_to category_lesson_path(category, @lesson)
    else
      flash[:danger] = t "alert_create_lesson_fail"
      redirect_to categories_path
    end
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
  end
end
