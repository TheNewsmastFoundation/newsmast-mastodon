# custom_feeds API Inventory

Source of truth: engine routes in config/routes.rb and mounted at root path in lib/custom_feeds/engine.rb.

## Endpoint Summary

Total endpoints: 4

| # | Method | Full Path | Controller#Action | Auth | Common Params (path/query/body) |
|---|---|---|---|---|---|
| 1 | GET | /api/v1/timelines/@:username/feed | custom_feeds/api/v1/timelines/feeds#show | Public | Path: username. Query: local, remote, only_media, limit, max_id, since_id, min_id. Body: none. |
| 2 | GET | /api/v1/timelines/for_you_custom_timeline | custom_feeds/api/v1/timelines/for_you_custom_timeline#show | Required | Path: none. Query: local, remote, only_media, grouped_admin_statuses, exclude_direct_statuses, exclude_replies, limit, max_id, since_id, min_id. Body: none. |
| 3 | POST | /api/v1/custom_statuses/add_custom_boost_bot_status | custom_feeds/api/v1/custom_statuses/custom_boost_bot_status#add_custom_boost_bot_status | Required | Path: none. Query: type, offset, min_id, max_id, account_id, following, exclude_unreviewed. Body: status_url, client_id, client_secret. |
| 4 | POST | /api/v1/custom_statuses/remove_custom_boost_bot_status | custom_feeds/api/v1/custom_statuses/custom_boost_bot_status#remove_custom_boost_bot_status | Required | Path: none. Query: none. Body: status_id, client_id, client_secret. |

## Auth Notes

- Public means no mandatory authentication in this engine endpoint.
- Required means authentication data is required by controller logic.
- The add/remove custom boost bot status endpoints require client_id and client_secret request params in controller code.
- The for_you_custom_timeline endpoint enforces OAuth scopes read and read:statuses plus user presence.
