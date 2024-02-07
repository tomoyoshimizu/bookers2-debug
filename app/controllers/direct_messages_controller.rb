class DirectMessagesController < ApplicationController

  before_action :not_myself, only: [:index, :create, :delete]

  def index
    @new_book = Book.new
    @new_message = DirectMessage.new
    @messages = DirectMessage.pair_of_users(current_user, @user)
  end

  def create
    message = DirectMessage.new(message_params)
    message.sender_id = current_user.id
    message.recipient_id = @user.id
    message.save
    @messages = DirectMessage.pair_of_users(current_user, @user)
    render "direct_messages/render_index"
  end

  def destroy
    DirectMessage.find(params[:id]).destroy
    @messages = DirectMessage.pair_of_users(current_user, @user)
    render "direct_messages/render_index"
  end

  private

  def message_params
    params.require(:direct_message).permit(:message)
  end

  def not_myself
    @user = User.find(params[:user_id])
    if @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
