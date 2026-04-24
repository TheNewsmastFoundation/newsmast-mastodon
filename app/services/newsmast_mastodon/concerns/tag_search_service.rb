# frozen_string_literal: true

# Source: content_filters/app/services/content_filters/concerns/tag_search_service.rb

module NewsmastMastodon
  module Concerns
    module TagSearchService
      extend ActiveSupport::Concern

      def from_elasticsearch
        definition = TagsIndex.query(elastic_search_query).filter(term: { is_banned: false })
        definition = definition.filter(elastic_search_filter) if @options[:exclude_unreviewed]

        ensure_exact_match(definition.limit(@limit).offset(@offset).objects.compact)
      rescue Faraday::ConnectionFailed, Parslet::ParseFailed
        nil
      end
    end
  end
end
