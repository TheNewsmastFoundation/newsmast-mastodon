# frozen_string_literal: true

# Stub definitions for Mastodon host-provided constants.
#
# The engine relies on many constants from the Mastodon host application that
# are NOT available in the minimal dummy Rails app used for unit testing.
# Defining stubs here lets spec files load (and discover pending examples via
# `require_host!`) without triggering Zeitwerk autoload failures.
#
# These stubs are intentionally minimal — they only supply enough structure for
# the engine files to be required without error.  Real behaviour is tested via
# the host-app integration harness.

# ---------------------------------------------------------------------------
# External gem stubs (not pulled into the test bundle)
# ---------------------------------------------------------------------------
unless defined?(Chewy)
  module Chewy
    class Index
      def self.index_name(*); end
      def self.index_scope(*); end
      def self.field(*); end
      def self.root(*); end
    end
  end
end

# ---------------------------------------------------------------------------
# Mastodon application-level stubs
# ---------------------------------------------------------------------------

# ApplicationMailer – base class for all Mastodon mailers
unless defined?(ApplicationMailer)
  class ApplicationMailer < ActionMailer::Base; end
end

# BaseService – base class for Mastodon service objects
unless defined?(BaseService)
  class BaseService
    def call(*); end
  end
end

# Redisable – mixed into Mastodon models / services for Redis helpers
unless defined?(Redisable)
  module Redisable
    def redis; end
  end
end

# Paginable – pagination concern used by Mastodon models
unless defined?(Paginable)
  module Paginable
    def self.included(base)
      base.extend(ClassMethods)
    end
    module ClassMethods
      def paginate_by_id(*); end
      def paginate_by_max_id(*); end
    end
  end
end

# DatabaseHelper – utility concern used in some Mastodon workers
unless defined?(DatabaseHelper)
  module DatabaseHelper
    def with_redis_tracking(*); yield if block_given?; end
  end
end

# RoutingHelper – Rails routing helpers mixed into Mastodon services
unless defined?(RoutingHelper)
  module RoutingHelper; end
end

# ActiveModel::Serializer – provided by active_model_serializers gem
unless defined?(ActiveModel::Serializer)
  module ActiveModel
    class Serializer
      def self.attribute(*); end
      def self.attributes(*); end
      def self.belongs_to(*); end
      def self.has_many(*); end
      def self.has_one(*); end
    end
  end
end

# REST namespace and serializers used by engine serializers
unless defined?(REST)
  module REST
    class MediaAttachmentSerializer < ActiveModel::Serializer; end
    class CredentialAccountSerializer < ActiveModel::Serializer; end
  end
end

# Paperclip's has_attached_file – mixed into ActiveRecord::Base by Mastodon
unless ActiveRecord::Base.respond_to?(:has_attached_file)
  ActiveRecord::Base.define_singleton_method(:has_attached_file) { |*| }
  ActiveRecord::Base.define_singleton_method(:validates_attachment) { |*| }
  ActiveRecord::Base.define_singleton_method(:validates_attachment_content_type) { |*| }
  ActiveRecord::Base.define_singleton_method(:validates_attachment_size) { |*| }
end

# ---------------------------------------------------------------------------
# Constants defined in sibling gems (local_only_posts, posts / long_post)
# ---------------------------------------------------------------------------

unless defined?(LocalOnlyPosts)
  module LocalOnlyPosts
    module StatusSerializerExtension; end
  end
end

unless defined?(LongPost)
  module LongPost
    module InstanceSerializerExtension; end
    module StatusLengthValidatorPatch; end
    class DraftedStatusSerializer; end
  end
end

# ---------------------------------------------------------------------------
# Engine constants that live outside the NewsmastMastodon namespace
# (top-level helpers / serializers defined in the engine but resolved at the
#  top level rather than inside the engine's isolated namespace)
# ---------------------------------------------------------------------------

unless defined?(BrandColorHelper)
  module BrandColorHelper
    def brand_color; '#6364ff'; end
  end
end

unless defined?(PatchworkHelper)
  module PatchworkHelper
    extend ActiveSupport::Concern
    def patchwork_table_exists?(_t) = false
    def patchwork_server_settings_exist?  = false
    def patchwork_community_admin_exist?  = false
  end
end

# Overrides::CredentialAccountSerializer lives outside NewsmastMastodon
unless defined?(Overrides)
  module Overrides
    module CredentialAccountSerializer; end
  end
end

# Expose the top-level stubs inside the NewsmastMastodon engine namespace so
# that specs describing e.g. `NewsmastMastodon::BrandColorHelper` resolve.
module NewsmastMastodon
  BrandColorHelper              = ::BrandColorHelper              unless const_defined?(:BrandColorHelper, false)
  PatchworkHelper               = ::PatchworkHelper               unless const_defined?(:PatchworkHelper, false)
  LocalOnlyPosts                = ::LocalOnlyPosts                unless const_defined?(:LocalOnlyPosts, false)
  LongPost                      = ::LongPost                      unless const_defined?(:LongPost, false)

  # CustomPasswordsMailer's source file defines it at top-level (no namespace
  # prefix), so Zeitwerk cannot resolve NewsmastMastodon::CustomPasswordsMailer
  # automatically in an isolated engine. Define a stub here.
  unless const_defined?(:CustomPasswordsMailer, false)
    class CustomPasswordsMailer < ActionMailer::Base; end
  end

  module Overrides
    CredentialAccountSerializer = ::Overrides::CredentialAccountSerializer unless const_defined?(:CredentialAccountSerializer, false)
  end
end
