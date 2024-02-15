class SortsController < ApplicationController

  def sort

    @sort_type = params[:sort_type]

    @books = case @sort_type
    when "newest" then
      Book.all.order("created_at DESC")
    when "trend" then
      Book.all.sort_by{|book| -book.favorites.created_while("this_week").count}
    when "rating"  then
      Book.all.order("score DESC")
    end

    @new_book = Book.new
    render "books/index"

  end

end
