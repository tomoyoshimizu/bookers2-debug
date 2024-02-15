class SortsController < ApplicationController

  def sort

    @sort_type = params[:sort_type]

    @books = case @sort_type
    when "newest" then
      Book.all.sort_by{|book| book[:created_at]}.reverse
    when "trend" then
      Book.all.sort_by{|book| -book.favorites.created_while("this_week").count}
    when "rating"  then
      Book.all.sort_by{|book| book[:score]}.reverse
    end

    @new_book = Book.new
    render "books/index"

  end

end
