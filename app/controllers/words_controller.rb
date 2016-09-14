class WordsController < ApplicationController
  before_action :require_logged_in_user, :load_filter_list, only: [:index]

  def index
    @categories = Category.all

    params[:filter_by] = :all.to_s if params[:filter_by].blank?

    @words = params[:filter_by] == :all.to_s ? Word.all :
      Word.send("#{params[:filter_by]}", current_user)

    @words = @words.by_category(params[:category_id])
      .paginate(page: params[:page])
      .per_page Settings.word_per_page
  end

  private
  def load_filter_list
    @list_filter = {}
    @list_filter[:learned] = t ".learned"
    @list_filter[:remembered] = t ".remember"
    @list_filter[:not_remembered] = t ".not-remember"
    @list_filter[:not_learned] = t ".notlearned"
    @list_filter[:unfinished] = t ".unfinished"
    @list_filter[:all] = t ".all"
  end
end
