# frozen_string_literal: true

module NewsmastMastodon
  module Concerns
    module SearchControllerExtension
      extend ActiveSupport::Concern

      private

      def search_params
        params.permit(:type, :offset, :min_id, :max_id, :account_id, :following, :local_only)
      end

      def combined_search_params
        super.merge(local_only: truthy_param?(:local_only))
      end
    end
  end
end
