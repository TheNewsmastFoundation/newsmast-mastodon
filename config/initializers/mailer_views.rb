# frozen_string_literal: true

# Source: accounts/config/initializers/mailer_views.rb (updated engine class)
Rails.application.config.to_prepare do
  NewsmastMastodon::Engine.paths['app/views'].existent.each do |path|
    ActionMailer::Base.prepend_view_path path
  end
end
