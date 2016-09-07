class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.update_desc
      .paginate(page: params[:page]).per_page Settings.page_size
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :description
  end
end
