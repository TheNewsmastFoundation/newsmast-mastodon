# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::ArticleNotificationService do
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

  it "fetches tokens for accounts with article_notifications enabled and sends Firebase notifications" do
    token_record = instance_double("TokenRecord", notification_token: "firebase-token")
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

    described_class.new.call({ "article_id" => 3, "title" => "A short title" })

    expect(NewsmastMastodon::FirebaseNotificationService).to have_received(:send_notification)
  end

  it "excludes Huawei tokens from Firebase delivery" do
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
    allow(final_relation).to receive(:find_each)

    described_class.new.call({ "article_id" => 4, "title" => "Another title" })

    expect(where_relation).to have_received(:not).with(platform_type: "huawei")
  end

  it "uses ARTICLE_NOTIFICATION_SENDER_NAME env var as the app title when set" do
    token_record = instance_double("TokenRecord", notification_token: "firebase-token")
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
    allow(ENV).to receive(:[]).with("ARTICLE_NOTIFICATION_SENDER_NAME").and_return("Patchwork News")

    allow(NewsmastMastodon::FirebaseNotificationService).to receive(:send_notification)
    described_class.new.call({ "article_id" => 5, "title" => "Hello world" })

    expect(NewsmastMastodon::FirebaseNotificationService).to have_received(:send_notification).with(
      "firebase-token",
      "Patchwork News",
      "Hello world",
      hash_including(noti_type: "new_article", article_id: 5)
    )
  end

  it "truncates the article title to 8 words in the notification body" do
    token_record = instance_double("TokenRecord", notification_token: "firebase-token")
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

    described_class.new.call({ "article_id" => 6, "title" => "one two three four five six seven eight nine" })

    expect(NewsmastMastodon::FirebaseNotificationService).to have_received(:send_notification).with(
      "firebase-token",
      anything,
      "one two three four five six seven eight...",
      anything
    )
  end
end
