class EventMailMailer < ApplicationMailer

  def send_mail(member, mail_values)
    @group = mail_values[:group]
    @title = mail_values[:title]
    @content = mail_values[:content]

    @mail = EventMailMailer.new()
    mail(
      from: @group.owner.email,
      to: member.email,
      subject: @title
    )
  end

  def self.send_mail_for_group(mail_values)
    group = mail_values[:group]
    group.joined_users.each do |member|
      unless user == group.owner
        EventMailMailer.send_mail(member, mail_values).deliver_now
      end
    end
  end

end
