class EventMailsController < ApplicationController

  def show
    @event_mail = EventMail.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  def new
    @test = "this is test"
    @new_event_mail = EventMail.new
    @group = Group.find(params[:group_id])
  end

  def create
    @event_mail = EventMail.new(event_mail_params)
    @group = Group.find(params[:group_id])
    @event_mail.group_id = @group.id

    if @event_mail.save

      # EventMailMailer.with(event_mail: @event_mail, group: @group).send_mail.deliver_now

      # Preview all emails at http://localhost:3000/rails/mailers/event_mail_mailer
      # check! => /bookers2-debug/test/mailers/previews/event_mail_mailer_preview.rb

      redirect_to group_event_mail_path(@group, @event_mail)
    else
      @test = event_mail_params
      @new_event_mail = @event_mail
      render 'event_mails/new'
    end

  end

  private

  def event_mail_params
    params.require(:event_mail).permit(:title, :content)
  end

end
