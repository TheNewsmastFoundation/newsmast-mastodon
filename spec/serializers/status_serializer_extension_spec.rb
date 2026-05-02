# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::LocalOnlyPosts::StatusSerializerExtension, type: :serializer do
  it "includes :local_only field in status JSON" do
    serializer_class = Class.new do
      def self.attributes(*attrs)
        @declared_attributes ||= []
        @declared_attributes.concat(attrs)
      end

      def self.declared_attributes
        @declared_attributes || []
      end

      include NewsmastMastodon::LocalOnlyPosts::StatusSerializerExtension
    end

    expect(serializer_class.declared_attributes).to include(:local_only)
  end
end
