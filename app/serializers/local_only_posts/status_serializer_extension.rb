# frozen_string_literal: true

# Source: local_only_posts/app/serializers/local_only_posts/status_serializer_extension.rb
module LocalOnlyPosts::StatusSerializerExtension
  extend ActiveSupport::Concern

  included do
    attributes :local_only
  end
end
