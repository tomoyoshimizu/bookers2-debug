class RelationshipsController < ApplicationController

  def create
    target_user = User.find(params[:user_id])
    current_user.follow_relationships.create(recipient_id: target_user.id)
    redirect_to request.referer
  end

  def destroy
    target_user = User.find(params[:user_id])
    current_user.follow_relationships.find_by(recipient_id: target_user.id).destroy
    redirect_to request.referer
  end

end
