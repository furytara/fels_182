class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page])
      .per_page Settings.page_size
  end
end
