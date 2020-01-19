class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user #mailの中で使いたいのでインスタンス変数に格上げ
    mail to: user.email
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
