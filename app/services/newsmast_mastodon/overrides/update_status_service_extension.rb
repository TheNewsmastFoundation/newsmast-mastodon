# frozen_string_literal: true

# Source: local_only_posts/app/services/local_only_posts/update_status_service_extension.rb

module NewsmastMastodon
  module Overrides
    module UpdateStatusServiceExtension
      private

      def broadcast_updates!
        DistributionWorker.perform_async(@status.id, { 'update' => true })
        ActivityPub::StatusUpdateDistributionWorker.perform_async(@status.id) unless @status.local_only?
      end
    end
  end
end
