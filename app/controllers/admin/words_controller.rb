class Admin::WordsController < ApplicationController
  before_action :load_word, only: [:edit, :update, :destroy]
  before_action :load_categories, except: [:destroy]

  def index
    @words = Word.by_category(params[:category_id])

    page = params[:page].to_i
    unless @words.size > (Settings.word_per_page * (page - 1))
      page -= 1
    end
    page = 1 if page <= 0

    @words = @words.paginate(page: page.to_i).
      per_page Settings.word_per_page
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

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t ".success"
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def destroy
    if @word.invalid_to_delete?
      flash[:danger] = t ".fail"
    else
      @word.destroy
      flash[:success] = t ".success"
    end
    redirect_to admin_words_path category_id: params[:category_id],
      page: params[:page]
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "not-exist-page"
      redirect_to admin_words_path
    end
  end

  def load_categories
    @categories = Category.alphabet
  end

  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :content, :is_true, :_destroy]
  end
end

