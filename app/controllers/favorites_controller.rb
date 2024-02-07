class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    current_user.favorites.create(book_id: @book.id)

    before_uri = URI.parse(request.referer)
    path = Rails.application.routes.recognize_path(before_uri.path)

    case path[:action]
    when "index" then
      period = 1.week.ago.beginning_of_day..Time.zone.now.end_of_day
      #テスト用（1時間以内）
      # period = 1.hour.ago..Time.zone.now
      @books = Book.all.sort_by { |book| -book.favorites.where(created_at: period).count }
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
      period = 1.week.ago.beginning_of_day..Time.zone.now.end_of_day
      #テスト用（1時間以内）
      # period = 1.hour.ago..Time.zone.now
      @books = Book.all.sort_by { |book| -book.favorites.where(created_at: period).count }
      render 'books/render_index'
    else
      render 'render_btn'
    end

  end

end
