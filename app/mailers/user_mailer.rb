class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
  	@user = user

    #@greeting = "Hi"

    mail to: user.email, subject: "Awesomeblog | Account Activation"
  end
end
