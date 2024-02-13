class EventMailMailer < ApplicationMailer

  def send_mail(event_mail:, group:)
    @event_mail = event_mail
    mailing_list = Array.new
    group.joined_users.each do |user|
      unless user == group.owner
        mailing_list.push(user.email)
      end
    end
    mail(
      from: group.owner.email,
      cc: mailing_list,
      subject: event_mail.title
    )
  end

end
