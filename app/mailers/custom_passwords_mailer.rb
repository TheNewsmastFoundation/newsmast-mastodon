# frozen_string_literal: true

# Source: accounts/app/mailers/custom_passwords_mailer.rb
class CustomPasswordsMailer < ApplicationMailer
  layout "email"

  helper BrandColorHelper
  helper LogoHelper

  def reset_password_confirmation
    @user = params[:user]

    if @user.present?
      @subject = "OTP verification code"
      mail(
        to: @user.email,
        subject: @subject
      )
    end
  end
end
