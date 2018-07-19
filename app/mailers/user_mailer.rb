class UserMailer < ApplicationMailer

  default from: "no-reply@jungle.com"

  def order_email(user)
    @user = user
    mail(to: @user.email, subject: @user.id)
  end
end
