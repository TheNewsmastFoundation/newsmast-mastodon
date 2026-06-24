# frozen_string_literal: true

module NewsmastMastodon
  module Overrides
    module ListTimelineControllerExtension
      include TimelinePatchworkPostReactions

      def show
        super
        decorate_list_timeline_response!
      end

      private

      def decorate_list_timeline_response!
        payload = json_payload_array(response.body)
        return if payload.empty?

        status_ids = payload.filter_map { |status| status['id']&.to_i }
        return if status_ids.empty?

        reactions_map = build_patchwork_post_reactions(Status.where(id: status_ids).select(:id).to_a)

        payload.each do |status|
          status_id = status['id']&.to_i
          status['patchwork_post_reactions'] = reactions_map[status_id] || []
        end

        self.response_body = JSON.generate(payload)
      end

      def json_payload_array(body)
        parsed = JSON.parse(body)
        parsed.is_a?(Array) ? parsed : []
      rescue JSON::ParserError
        []
      end
    end
  end
end