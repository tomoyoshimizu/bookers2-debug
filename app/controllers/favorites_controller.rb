class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    current_user.favorites.create(book_id: book.id)
    redirect_to request.referer
  end

  def destroy
    book = Book.find(params[:book_id])
    current_user.favorites.find_by(book_id: book.id).destroy
    redirect_to request.referer
  end

end
