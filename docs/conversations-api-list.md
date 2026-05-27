# Conversations Gem API Inventory

This inventory is generated from engine routes and controllers in this gem:
- `config/routes.rb`
- `app/controllers/conversations/api/v1/patchwork/conversations_controller.rb`

## Endpoint Summary

- Total endpoints: **2**
- Public endpoints: **0**
- Auth required endpoints: **2**

## API Routes

| Method | Full Path | Controller#Action | Auth | Common Params |
|---|---|---|---|---|
| GET | /api/v1/patchwork/conversations/check_conversation | conversations/api/v1/patchwork/conversations#check_conversation | Required | **Query:** `target_account_id` (required), `max_id` (optional), `since_id` (optional), `min_id` (optional) |
| POST | /api/v1/patchwork/conversations/read_all | conversations/api/v1/patchwork/conversations#read_all | Required | **Body:** none required (empty JSON allowed) |

## Endpoint Details

### GET /api/v1/patchwork/conversations/check_conversation

- Controller action: `Conversations::Api::V1::Patchwork::ConversationsController#check_conversation`
- Auth: **Required**
- OAuth scopes (from controller before_action): `read`, `read:statuses`
- Path params: none
- Query params:
  - `target_account_id` (required)
  - `max_id` (optional)
  - `since_id` (optional)
  - `min_id` (optional)
- Body params: none

Example request:

```http
GET {{base_url}}/api/v1/patchwork/conversations/check_conversation?target_account_id={{target_account_id}}&max_id={{max_id}}&since_id={{since_id}}&min_id={{min_id}}
Authorization: Bearer {{access_token}}
```

### POST /api/v1/patchwork/conversations/read_all

- Controller action: `Conversations::Api::V1::Patchwork::ConversationsController#read_all`
- Auth: **Required**
- OAuth scopes (from controller before_action): `write`, `write:conversations`
- Path params: none
- Query params: none
- Body params: none required

Example request:

```http
POST {{base_url}}/api/v1/patchwork/conversations/read_all
Authorization: Bearer {{access_token}}
Content-Type: application/json

{}
```

## Notes

- No public API endpoints are defined by this gem route/controller surface.
- Auth classification is based on `doorkeeper_authorize!` and `require_user!` in the mapped controller.
