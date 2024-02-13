class EventMailsController < ApplicationController

  def show
    @group = Group.find(params[:group_id])
  end

  def new
    @group = Group.find(params[:group_id])
  end

  def create

    @group = Group.find(params[:group_id])
    @title = params[:title]
    @content = params[:content]

    mail_values = { group: @group, title: @title, content: @content }

    # EventMailMailer.send_mail_for_group(mail_values)

    # Preview all emails at http://localhost:3000/rails/mailers/event_mail_mailer
    # check! => /bookers2-debug/test/mailers/previews/event_mail_mailer_preview.rb

    render :sent

  end

  def sent
    redirect_to group_path(params[:group_id])
  end

  private

  def event_mail_params
    params.require(:event_mail).permit(:title, :content)
  end

end
