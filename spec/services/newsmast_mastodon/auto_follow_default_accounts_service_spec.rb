# frozen_string_literal: true

require "rails_helper"

RSpec.describe NewsmastMastodon::AutoFollowDefaultAccountsService, type: :service do
  it "reads account handles from ENV and follows each" do
    source_account = instance_double("Account", local?: true, acct: "source")
    target_one = instance_double("Account", acct: "one")
    target_two = instance_double("Account", acct: "two")

    resolve_service = instance_double("ResolveAccountService")
    resolve_service_class = class_double("ResolveAccountService", new: resolve_service)
    stub_const("ResolveAccountService", resolve_service_class)

    allow(resolve_service).to receive(:call).with("@one@example.org").and_return(target_one)
    allow(resolve_service).to receive(:call).with("@two@example.org").and_return(nil)
    allow(resolve_service).to receive(:call).with("@two@example.org", skip_webfinger: true).and_return(target_two)

    follow_service = instance_double("FollowService", call: true)
    follow_service_class = class_double("FollowService", new: follow_service)
    stub_const("FollowService", follow_service_class)

    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("AUTO_FOLLOW_ACCOUNTS").and_return("@one@example.org,@two@example.org")

    described_class.new.call(source_account)

    expect(follow_service).to have_received(:call).with(source_account, target_one, bypass_locked: true, bypass_limit: true)
    expect(follow_service).to have_received(:call).with(source_account, target_two, bypass_locked: true, bypass_limit: true)
  end
end
