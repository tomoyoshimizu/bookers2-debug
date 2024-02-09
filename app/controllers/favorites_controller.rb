class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    current_user.favorites.create(book_id: @book.id)

    before_uri = URI.parse(request.referer)
    path = Rails.application.routes.recognize_path(before_uri.path)

    case path[:action]
    when "index" then
      @books = Book.trend
      render 'books/render_index'
    else
      render 'render_btn'
    end

  end

  def destroy
    @book = Book.find(params[:book_id])
    current_user.favorites.find_by(book_id: @book.id).destroy

    before_uri = URI.parse(request.referer)
    path = Rails.application.routes.recognize_path(before_uri.path)

    case path[:action]
    when "index" then
      @books = Book.trend
      render 'books/render_index'
    else
      render 'render_btn'
    end

  end

end
