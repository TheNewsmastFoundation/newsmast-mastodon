# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::PatchworkHelper, type: :helper do
  it "#patchwork_table_exists? detects the patchwork table" do
    connection = instance_double("ActiveRecordConnection", data_source_exists?: true)
    allow(ActiveRecord::Base).to receive(:connection).and_return(connection)

    expect(helper.patchwork_table_exists?("server_settings")).to be(true)
  end

  it "#patchwork_server_settings_exist? detects settings rows" do
    allow(helper).to receive(:patchwork_table_exists?).with("server_settings").and_return(true)

    stub_const("NewsmastMastodon::ServerSetting", Class.new do
      def self.find_by(*); end
    end)

    expect(helper.patchwork_server_settings_exist?).to be(true)
  end

  it "#patchwork_community_admin_exist? detects admin rows" do
    allow(helper).to receive(:patchwork_table_exists?).with("patchwork_communities_admins").and_return(true)

    stub_const("NewsmastMastodon::CommunityAdmin", Class.new do
      def self.find_by(*); end
    end)

    expect(helper.patchwork_community_admin_exist?).to be(true)
  end
end
