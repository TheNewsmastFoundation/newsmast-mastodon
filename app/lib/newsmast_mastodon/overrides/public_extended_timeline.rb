# frozen_string_literal: true

# Merged from:
#   content_filters/.../public_extended_timeline.rb  (grouped_admin_statuses, with_reblogs)
#   timelines_extension/.../public_extended_timeline.rb (with_replies)
module NewsmastMastodon
  module Overrides
    module PublicExtendedTimeline
      PERMITTED_PARAMS = %i(local remote limit only_media with_reblogs with_replies grouped_admin_statuses).freeze

      def public_feed
        PublicFeed.new(
          current_account,
          local: truthy_param?(:local),
          remote: truthy_param?(:remote),
          only_media: truthy_param?(:only_media),
          with_reblogs: truthy_param?(:with_reblogs),
          with_replies: truthy_param?(:with_replies),
          grouped_admin_statuses: truthy_param?(:grouped_admin_statuses)
        )
      end
    end
  end
end
