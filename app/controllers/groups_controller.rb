class GroupsController < ApplicationController

  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @new_book = Book.new
    @groups = Group.all
  end

  def show
    @new_book = Book.new
    @group = Group.find(params[:id])
  end

  def new
    @new_book = Book.new
    @new_group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      GroupUser.create(user_id: current_user.id, group_id: @group.id)
      redirect_to group_path(@group), notice: "You have created group successfully."
    else
      @new_book = Book.new
      @new_group = @group
      render "new"
    end
  end

  def edit
    @new_book = Book.new
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "You have updated group successfully."
    else
      @new_book = Book.new
      render "edit"
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    @new_book = Book.new
    @groups = Group.all
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to group_path(@group)
    end
  end
end
