module NewsmastMastodon::Api::V1::Timelines
  class ForYouCustomTimelineController < ::Api::V1::Timelines::BaseController
    include NewsmastMastodon::Overrides::TimelinePatchworkPostReactions

    before_action -> { doorkeeper_authorize! :read, :'read:statuses' }
    before_action :require_user!

    PERMITTED_PARAMS = %i(local remote limit only_media grouped_admin_statuses exclude_direct_statuses exclude_replies).freeze

    def show
      cache_if_unauthenticated!
      @statuses = load_statuses
      @patchwork_post_reactions = build_patchwork_post_reactions(@statuses)

      render json: @statuses,
             each_serializer: REST::StatusSerializer,
             relationships: StatusRelationshipsPresenter.new(@statuses, current_user&.account_id),
             include_patchwork_post_reactions: true,
             patchwork_post_reactions: @patchwork_post_reactions
    end

    private

    def load_statuses
      preloaded_for_you_statuses_page
    end

    def preloaded_for_you_statuses_page
      preload_collection(for_you_statuses, Status)
    end

    def for_you_statuses
      foryou_feed.get(
        limit_param(DEFAULT_STATUSES_LIMIT),
        params[:max_id],
        params[:since_id],
        params[:min_id],
      )
    end

    def foryou_feed
      NewsmastMastodon::ForYouFeed.new(
        current_account,
        grouped_admin_statuses: truthy_param?(:grouped_admin_statuses),
        exclude_direct_statuses: truthy_param?(:exclude_direct_statuses),
        exclude_replies: truthy_param?(:exclude_replies)
      )
    end

    def next_path
      api_v1_timelines_for_you_custom_timeline_url next_path_params
    end

    def prev_path
      api_v1_timelines_for_you_custom_timeline_url prev_path_params
    end
  end
end