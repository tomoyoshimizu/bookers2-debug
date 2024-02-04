class RelationshipsController < ApplicationController

  def create
    target_user = User.find(params[:user_id])
    follow_relationship = current_user.request_follow.new(recipient_id: target_user.id)
    follow_relationship.save
    redirect_to request.referer
  end

  def destroy
    target_user = User.find(params[:user_id])
    follow_relationship = current_user.request_follow.find_by(recipient_id: target_user.id)
    follow_relationship.destroy
    redirect_to request.referer
  end

end
