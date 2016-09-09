class Admin::WordsController < ApplicationController
  def index
    @words = Word.all
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

