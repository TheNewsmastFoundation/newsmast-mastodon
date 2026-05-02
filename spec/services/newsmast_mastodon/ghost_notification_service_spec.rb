# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::GhostNotificationService, type: :service do
  before do
    notification_token_class = Class.new do
      def self.table_name = "notification_tokens"
      def self.joins(*); end
    end

    patchwork_setting_class = Class.new do
      def self.table_name = "patchwork_settings"
    end

    stub_const("NewsmastMastodon::NotificationToken", notification_token_class)
    stub_const("NewsmastMastodon::PatchworkSetting", patchwork_setting_class)
  end

  it "queries NotificationToken for leicester_notification subscribers" do
    token_record = instance_double("TokenRecord", notification_token: "tok-1")

    base_relation = instance_double("NotificationTokenRelation")
    filtered_relation = instance_double("FilteredRelation")
    selected_relation = instance_double("SelectedRelation")
    where_relation = instance_double("WhereRelation")
    final_relation = instance_double("FinalRelation")

    allow(NewsmastMastodon::NotificationToken).to receive(:joins).and_return(base_relation)
    allow(base_relation).to receive(:where).and_return(filtered_relation)
    allow(filtered_relation).to receive(:select).and_return(selected_relation)
    allow(selected_relation).to receive(:where).and_return(where_relation)
    allow(where_relation).to receive(:not).with(platform_type: "huawei").and_return(final_relation)
    allow(final_relation).to receive(:find_each).and_yield(token_record)

    allow(NewsmastMastodon::FirebaseNotificationService).to receive(:send_notification)

    described_class.new.call({ "article_id" => 9, "title" => "Alpha beta gamma" })

    expect(NewsmastMastodon::NotificationToken).to have_received(:joins)
  end

  it "sends via FirebaseNotificationService" do
    token_record = instance_double("TokenRecord", notification_token: "tok-2")

    base_relation = instance_double("NotificationTokenRelation")
    filtered_relation = instance_double("FilteredRelation")
    selected_relation = instance_double("SelectedRelation")
    where_relation = instance_double("WhereRelation")
    final_relation = instance_double("FinalRelation")

    allow(NewsmastMastodon::NotificationToken).to receive(:joins).and_return(base_relation)
    allow(base_relation).to receive(:where).and_return(filtered_relation)
    allow(filtered_relation).to receive(:select).and_return(selected_relation)
    allow(selected_relation).to receive(:where).and_return(where_relation)
    allow(where_relation).to receive(:not).with(platform_type: "huawei").and_return(final_relation)
    allow(final_relation).to receive(:find_each).and_yield(token_record)

    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("GHOST_NOTIFICATION_SENDER_NAME").and_return("Ghost Sender")

    allow(NewsmastMastodon::FirebaseNotificationService).to receive(:send_notification)

    described_class.new.call({ "article_id" => 11, "title" => "One two three four five six seven eight nine" })

    expect(NewsmastMastodon::FirebaseNotificationService).to have_received(:send_notification).with(
      "tok-2",
      "Ghost Sender",
      "One two three four five six seven eight...",
      hash_including(noti_type: "ghost_articles", article_id: 11)
    )
  end
end
