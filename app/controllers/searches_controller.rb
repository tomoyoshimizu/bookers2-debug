class SearchesController < ApplicationController

  def search
    @search_word = params[:search_word]
    @search_model = params[:search_model]

    case @search_model
    when "User" then
      model_class = User
    when "Book" then
      model_class = Book
    end

    @search_result = model_class.search(@search_word, params[:search_type])

    @new_book = Book.new
  end

  def search_date
    @search_date = params[:search_date]
    @user = User.find(params[:user_id])
  end

  def search_tag
    @search_tag = params[:search_tag]

    if @search_tag.present?
      @search_result = Book.where("tag LIKE ?", @search_tag)
    else
      @search_result = Book.all
    end

    @new_book = Book.new
  end

end
