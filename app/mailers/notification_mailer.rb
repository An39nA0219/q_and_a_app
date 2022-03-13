class NotificationMailer < ApplicationMailer
  default from: 'techessentials.mailtest@gmail.com'

  def notification_of_getting_question(user, question)
    @user = user
    @question = question
    mail(
      to: user.email,
      subject: '質問を受け付けました'
    )
  end

  def notification_of_getting_answer(user, answer)
    @user = user
    @answer = answer
    mail(
      to: user.email,
      subject: '回答を受け付けました'
    )
  end
end
