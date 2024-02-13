# Preview all emails at http://localhost:3000/rails/mailers/event_mail_mailer
class EventMailMailerPreview < ActionMailer::Preview

  def send_mail
    mail_values = { group: Group.find(2), title: "タイトル", content: "内容"}
    EventMailMailer.send_mail(User.find(1), mail_values)
  end

end
