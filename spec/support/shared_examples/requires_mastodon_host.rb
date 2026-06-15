# frozen_string_literal: true

# Reusable examples for host-class-dependent behaviour.
# Individual specs include these with `it_behaves_like "..."`.

RSpec.shared_examples "requires Mastodon host" do |reason = "host classes unavailable"|
  it "is pending until Mastodon host is available (#{reason})" do
    pending("Mastodon host integration required")
    raise
  end
end
