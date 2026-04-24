# frozen_string_literal: true

# Source: accounts/app/models/concerns/override_changed_password.rb
module NewsmastMastodon
  module Concerns
    module OverrideChangedPassword
      extend ActiveSupport::Concern

      included do
        # Transient attribute to control notification skipping
        attr_accessor :skip_password_change_notification

        def render_and_send_devise_message(notification_type, *args)
          # Skip sending password_change email if the flag is set
          return if notification_type == skip_password_change_notification

          devise_mailer.send(notification_type, self, *args).deliver_later
        end

        def send_password_change_notification
          return if skip_password_change_notification

          render_and_send_devise_message(:password_change)
        end
      end
    end
  end
end
