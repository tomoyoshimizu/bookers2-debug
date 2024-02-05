class SearchesController < ApplicationController

  def search
    @search_word = search_params[:search_word]
    @search_model = search_params[:search_model]

    case @search_model
    when "User" then
      referenced_model = User
    when "Book" then
      referenced_model = Book
    end

    @result = referenced_model.search(@search_word, search_params[:search_type])

    @new_book = Book.new
  end

  private

  def search_params
    params.permit(:search_word, :search_model, :search_type)
  end

end
