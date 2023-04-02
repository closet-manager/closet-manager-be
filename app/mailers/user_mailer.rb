class UserMailer < ApplicationMailer

  def list_creation_email
    @user = params[:user]
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'You Have Created a List!')
  end
end