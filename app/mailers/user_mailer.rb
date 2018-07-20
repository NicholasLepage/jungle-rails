class UserMailer < ApplicationMailer

  def sample_email(order)
    @order = order
    mail(to: @order.email, subject: @order.id)
  end
  
end
