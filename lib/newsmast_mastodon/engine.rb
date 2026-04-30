# frozen_string_literal: true

module NewsmastMastodon
  class Engine < ::Rails::Engine
    isolate_namespace NewsmastMastodon

    # --- Doorkeeper password grant (from accounts engine) ---
    config.after_initialize do
      next unless defined?(Doorkeeper)

      Doorkeeper.configuration.instance_eval do
        @grant_flows = (@grant_flows || []) | ['password']
        @resource_owner_from_credentials = proc do |_routes|
          user   = User.authenticate_with_ldap(email: request.params[:username], password: request.params[:password]) if Devise.ldap_authentication
          user ||= User.authenticate_with_pam(email: request.params[:username], password: request.params[:password]) if Devise.pam_authentication
          if user.nil?
            user = User.find_by(email: request.params[:username])
            user = nil unless user&.valid_password?(request.params[:password])
          end
          user unless user&.otp_required_for_login?
        end
      end
    end

    # --- Append migrations (from all gems) ---
    initializer :append_migrations do |app|
      unless app.root.to_s == root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    # --- Mount routes at "/" ---
    initializer 'newsmast_mastodon.load_routes' do |app|
      app.routes.prepend do
        mount NewsmastMastodon::Engine => "/", :as => :newsmast_mastodon
      end
    end

    # --- Autoload paths for services, workers, presenters ---
    config.autoload_paths << File.expand_path("../app/services", __FILE__)
    config.autoload_paths << File.expand_path("../app/workers", __FILE__)
    config.autoload_paths += %W(#{config.root}/app/presenters)

    # --- Ghost & WordPress webhook host allowlisting (from posts engine) ---
    initializer 'newsmast_mastodon.extend_allowed_hosts' do |app|
      allowed_hosts = []

      if ENV.values_at('GHOST_URL', 'GHOST_WEBHOOK_TARGET_URL', 'GHOST_WEBHOOK_SECRET').all?(&:present?)
        allowed_hosts << ENV['GHOST_URL']
      end

      if ENV['WORDPRESS_URL'].present?
        allowed_hosts << ENV['WORDPRESS_URL']
      end

      allowed_hosts.each do |host|
        clean_host = host.gsub(%r{^https?://}, '').split('/').first
        app.config.hosts << clean_host unless app.config.hosts.include?(clean_host)
      end
    end

    # --- Chewy autoload exclusion (from content_filters engine) ---
    initializer 'newsmast_mastodon.exclude_chewy_autoload', before: :set_autoload_paths do |app|
      gem_root = root.to_s
      chewy_path = File.join(gem_root, "app", "chewy", "newsmast_mastodon")
      config.autoload_paths.delete(chewy_path)
      config.eager_load_paths.delete(chewy_path)
      config.paths.add "app/chewy", with: []
      config.paths.add "app/chewy/newsmast_mastodon", with: []
    end

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
