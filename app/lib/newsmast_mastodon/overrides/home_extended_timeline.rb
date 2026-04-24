# frozen_string_literal: true

# Merged from:
#   content_filters/app/lib/content_filters/overrides/home_extended_timeline.rb
#     (adds exclude_direct_statuses, grouped_admin_statuses params)
#   timelines_extension/app/lib/timelines_extension/overrides/home_extended_timeline.rb
#     (adds exclude_directs, exclude_followed_tags, exclude_replies params)
#
# The merged FeedConcern#get signature supports the union of parameters from both
# engines. Callers may use either :exclude_direct_statuses or :exclude_directs.
module NewsmastMastodon
  module Overrides
    module HomeExtendedTimeline
      DEFAULT_STATUSES_LIMIT = 20

      def home_statuses
        account_home_feed.get(
          limit_param(DEFAULT_STATUSES_LIMIT),
          params[:max_id],
          params[:since_id],
          params[:min_id],
          current_account,
          truthy_param?(:exclude_direct_statuses) || truthy_param?(:exclude_directs),
          truthy_param?(:exclude_followed_tags),
          truthy_param?(:exclude_replies),
          truthy_param?(:grouped_admin_statuses)
        )
      end
    end
  end
end
