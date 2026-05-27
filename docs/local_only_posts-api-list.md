# local_only_posts API Inventory

Generated from routes and controllers in this gem only.

Sources:
- `config/routes.rb`
- `lib/local_only_posts/engine.rb`
- `app/controllers/local_only_posts/api/v1/local_only_posts_controller.rb`

## Route Inventory

| Method | Full Path | Controller#Action | Auth | Path Params | Query Params | Body Params |
| --- | --- | --- | --- | --- | --- | --- |
| GET | /api/v1/local_only_posts/getLocalOnlySetting | local_only_posts/api/v1/local_only_posts#getLocalOnlySetting | Required (Bearer token) | None | None | None |

## Auth Rules

- `GET /api/v1/local_only_posts/getLocalOnlySetting` requires authentication.
- Evidence: `before_action :require_user!, only: [:getLocalOnlySetting]` in `LocalOnlyPosts::Api::V1::LocalOnlyPostsController`.

## Notes

- The engine is mounted at `/` via `mount LocalOnlyPosts::Engine => "/"` in `lib/local_only_posts/engine.rb`, so engine routes are exposed directly under `/api/v1/...`.
- This gem also prepends behavior into existing Mastodon controllers/services, but those upstream routes are not defined in this gem and are therefore excluded from this inventory.