# frozen_string_literal: true

# Source: accounts/app/helpers/non_channel_helper.rb
module NonChannelHelper
  extend ActiveSupport::Concern

  def is_non_channel?
    return false if Rails.env.development?

    return true unless ENV.fetch('LOCAL_DOMAIN', nil) == 'channel.org' || ENV.fetch('LOCAL_DOMAIN', nil) == 'staging.patchwork.online'

    false
  end
end
