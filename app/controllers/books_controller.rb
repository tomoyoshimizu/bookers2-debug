class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @new_comment = Comment.new

    current_user_access = @book.access_records.find_by(user_id: current_user.id)

    if current_user_access.nil?
      @book.access_records.create(user_id: current_user.id, count: 1)
    else
      if Time.current.yesterday > current_user_access[:updated_at]
        count_up = current_user_access[:count] + 1
        current_user_access.update(count: count_up)
      end
    end

  end

  def index
    @books = Book.trend
    @new_book = Book.new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book), notice: "You have created book successfully."
    else
      @books = Book.trend
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
