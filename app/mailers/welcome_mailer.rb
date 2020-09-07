class WelcomeMailer < ApplicationMailer
  default from: 'kanwartestemail@gmail.com'
  layout 'email'
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
