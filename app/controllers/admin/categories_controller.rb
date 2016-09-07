class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.update_desc
      .paginate(page: params[:page]).per_page Settings.page_size
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".success"
      redirect_to admin_categories_path
    else
      render :edit
    end
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

  def destroy
    if @category.valid_to_delete?
      flash[:danger] = t ".fail"
    else
      @category.destroy
      flash[:success] = t ".success"
    end
    redirect_to admin_categories_path
  end

  private
  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "not-exist-page"
      redirect_to admin_categories_path
    end
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end
