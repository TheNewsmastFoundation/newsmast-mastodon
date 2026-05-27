# Accounts Gem API List for Postman

This document lists all API endpoints defined in this gem engine routes so they can be added to a Postman collection.

## Base URL

- Path prefix in this gem: /api/v1
- Final URL depends on where the engine is mounted in the host app.
- Example: https://your-host.example/api/v1

## Authentication

- Most endpoints require a user bearer token with scopes: read and write.
- Header:
  - Authorization: Bearer <access_token>
  - Content-Type: application/json

## Endpoint List

| Method | Path | Controller#Action | Auth | Common Request Fields |
|---|---|---|---|---|
| POST | /api/v1/custom_passwords | custom_passwords#create | Public | email |
| PATCH or PUT | /api/v1/custom_passwords/:id | custom_passwords#update | Public | password, password_confirmation |
| POST | /api/v1/custom_passwords/verify_otp | custom_passwords#verify_otp | Public | id, otp_secret, is_reset_password, is_change_email, invitation_code, skip_waitlist, email |
| GET | /api/v1/custom_passwords/request_otp | custom_passwords#request_otp | Public | id (token or reset token), email |
| POST | /api/v1/custom_passwords/change_password | custom_passwords#change_password | Required | current_password, password, password_confirmation |
| POST | /api/v1/custom_passwords/change_email | custom_passwords#change_email | Required | current_password, email |
| POST | /api/v1/custom_passwords/bristol_cable_sign_in | custom_passwords#bristol_cable_sign_in | Public | username, email, password |
| POST | /api/v1/notification_tokens | notification_tokens#create | Required | notification_token, platform_type, mute |
| POST | /api/v1/notification_tokens/revoke_token | notification_tokens#revoke_notification_token | Required | notification_token |
| POST | /api/v1/notification_tokens/update_mute | notification_tokens#update_mute | Required | mute |
| GET | /api/v1/notification_tokens/get_mute_status | notification_tokens#get_mute_status | Required | None |
| DELETE | /api/v1/notification_tokens/reset_device_tokens/:platform_type | notification_tokens#reset_device_tokens | Required | platform_type (path) |
| POST | /api/v1/user_locales | user_locales#create | Required | lang |
| GET | /api/v1/channels/starter_packs_channels | channels#starter_packs_channels | Required | starter_pack_source (query, optional) |
| GET | /api/v1/channels/:id/starter_packs_detail | channels#starter_packs_detail | Required | id (path), starter_pack_source (query, optional) |
| GET | /api/v1/patchwork/alttext_settings | patchwork/alttext_settings#index | Required | None |
| POST | /api/v1/patchwork/alttext_settings/alttext | patchwork/alttext_settings#change_alttext_setting | Required | enabled |
| GET | /api/v1/patchwork/email_settings | patchwork/email_settings#index | Required | None |
| POST | /api/v1/patchwork/email_settings/notification | patchwork/email_settings#email_notification | Required | allowed |
| DELETE | /api/v1/patchwork/account_deletion/:id | patchwork/account_deletion#destroy | Required | id (path) |
| POST | /api/v1/delete_account | accounts#delete_account | Required | password |
| GET | /api/v1/accounts/leicester_notification | accounts/patchwork_settings#leicester_news_notification | Required | app_name (optional) |
| POST | /api/v1/accounts/leicester_notification | accounts/patchwork_settings#update_leicester_news_notification | Required | allowed, app_name (optional) |
| POST | /api/v1/accounts/subscribe_leicester | accounts/ghost_subscriptions#manage_subscription | Required | email, subscribe |
| GET | /api/v1/accounts/article_notifications | accounts/patchwork_settings#article_notifications | Required | app_name (optional) |
| POST | /api/v1/accounts/article_notifications | accounts/patchwork_settings#update_article_notifications | Required | allowed, app_name (optional) |

## Suggested Postman Variables

- base_url = https://your-host.example
- access_token = user access token
- account_id = account id for account deletion route
- channel_id = channel id for starter pack detail route
- platform_type = ios or android (as used by your app)

## Notes

- Public means no authenticated user is required in this controller.
- Required means authenticated user and doorkeeper scopes read/write are enforced.
- Some fields above are optional or context-dependent; they are included to speed up collection setup.