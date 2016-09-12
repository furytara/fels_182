class Admin::WordsController < ApplicationController
  def index
    @categories = Category.alphabet
    @words = Word.by_category(params[:category_id])
      .paginate(page: params[:page]).per_page Settings.word_per_page
  end

  def new
    @word = Word.new
    Settings.answers_num_default.times {@word.answers.build}
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t ".success"
      redirect_to admin_words_path
    else
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:content, :is_true]
  end
end

