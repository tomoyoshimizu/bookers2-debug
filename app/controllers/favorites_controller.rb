class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    current_user.favorites.create(book_id: @book.id)
    render 'render_btn'
  end

  def destroy
    @book = Book.find(params[:book_id])
    current_user.favorites.find_by(book_id: @book.id).destroy
    render 'render_btn'
  end

end
