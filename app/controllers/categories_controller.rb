class CategoriesController < ApplicationController
  before_action :require_logged_in_user
  def index
    @categories = Category.paginate(page: params[:page])
      .per_page Settings.page_size
  end
end
