# Preview all emails at http://localhost:3000/rails/mailers/event_mail_mailer
class EventMailMailerPreview < ActionMailer::Preview
  
  def send_mail
    event_mail = EventMail.new(title: "タイトル", content: "内容")
    group = Group.find(2)
    EventMailMailer.send_mail(event_mail: event_mail, group: group)
  end

end
