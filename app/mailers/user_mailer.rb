class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user #mailの中で使いたいのでインスタンス変数に格上げ
    mail to: user.email
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
