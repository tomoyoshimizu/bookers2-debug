class CommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.book_id = @book.id
    comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
