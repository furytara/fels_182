class Admin::CategoriesController < ApplicationController
  before_action :require_logged_in_user, :require_logged_in_as_admin
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    if params[:search]
      @categories = Category.search params[:search]
    else
      @categories = Category.update_desc
    end

    page = params[:page].to_i
    unless @categories.size > (Settings.page_size * (page - 1))
      page -= 1
    end
    page = 1 if page <= 0

    @categories = @categories.paginate(page: page.to_s)
      .per_page Settings.page_size
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
    redirect_to admin_categories_path(search: params[:search],
      page: params[:page])
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
