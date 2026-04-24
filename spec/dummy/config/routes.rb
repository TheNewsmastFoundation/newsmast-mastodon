Rails.application.routes.draw do
  mount NewsmastMastodon::Engine => "/newsmast_mastodon"
end
