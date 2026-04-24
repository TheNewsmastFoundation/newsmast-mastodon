# frozen_string_literal: true

# Source: accounts/config/initializers/mailer_overrides.rb
Rails.application.config.to_prepare do
  ActionMailer::Base.helper LogoHelper
  ActionMailer::Base.helper BrandColorHelper
end
