# frozen_string_literal: true

# Consolidated install task: copies Chewy indexes and frontend overrides
# from the newsmast_mastodon gem into the host Mastodon application.
#
# Supersedes the per-gem install tasks:
#   * content_filters:install     (Chewy index files)
#   * local_only_posts:install    (JS + view overrides)
require 'fileutils'

namespace :newsmast_mastodon do
  desc 'Install newsmast_mastodon Chewy indexes and frontend overrides into the host Mastodon app'
  task install: :environment do
    spec = Gem.loaded_specs['newsmast_mastodon']
    abort 'newsmast_mastodon gem not found' unless spec

    gem_root = spec.full_gem_path

    install_chewy_indexes!(gem_root)
    install_frontend_overrides!(gem_root)
    create_marker_file!

    puts "\nnewsmast_mastodon has been successfully installed."
    puts 'JS changes require `yarn build`. Run `yarn build:development` or `yarn build:production`.'
  end

  # -------------------
  # Chewy index install
  # -------------------
  # (from content_filters/lib/tasks/content_filters_install.rake)
  def install_chewy_indexes!(gem_root)
    source_path      = File.join(gem_root, 'app', 'chewy', 'newsmast_mastodon')
    destination_path = Rails.root.join('app', 'chewy')

    unless Dir.exist?(source_path)
      puts "Skipping Chewy install (source directory not found: #{source_path})"
      return
    end

    FileUtils.mkdir_p(destination_path)
    puts 'Copying and transforming Chewy index files from newsmast_mastodon gem...'

    Dir.glob(File.join(source_path, '*.rb')).each do |file|
      filename         = File.basename(file)
      destination_file = File.join(destination_path, filename)

      # Strip the NewsmastMastodon:: namespace so the host app consumes the
      # indexes as top-level constants (matches content_filters:install).
      content             = File.read(file)
      transformed_content = content.gsub(/class\s+NewsmastMastodon::(\w+Index)\s+</, 'class \1 <')

      File.write(destination_file, transformed_content)
      puts "  - Copied and transformed #{filename}"
    end

    puts "Chewy index files copied to #{destination_path}/"
  end

  # ------------------------
  # Frontend overrides install
  # ------------------------
  # (from local_only_posts/lib/tasks/local_only_posts_tasks.rake)
  def install_frontend_overrides!(gem_root)
    overrides = [
      {
        label:       'JS',
        source_root: File.join(gem_root, 'app/javascript/newsmast_mastodon/mastodon'),
        target_root: Rails.root.join('app/javascript/mastodon'),
        files:       {
          'actions/compose.js'                                            => 'actions/compose.js',
          'reducers/compose.js'                                           => 'reducers/compose.js',
          'features/compose/components/compose_form.jsx'                  => 'features/compose/components/compose_form.jsx',
          'features/compose/containers/compose_form_container.js'         => 'features/compose/containers/compose_form_container.js',
          'features/status/components/detailed_status.tsx'                => 'features/status/components/detailed_status.tsx',
          'features/compose/components/federated_dropdown.jsx'            => 'features/compose/components/federated_dropdown.jsx',
          'features/compose/containers/federated_dropdown_container.js'   => 'features/compose/containers/federated_dropdown_container.js',
        },
      },
      {
        label:       'VIEW',
        source_root: File.join(gem_root, 'app/views'),
        target_root: Rails.root.join('app/views'),
        files:       {
          'admin/shared/_status.html.haml' => 'admin/shared/_status.html.haml',
        },
      },
    ]

    puts "\nApplying newsmast_mastodon frontend overrides..."

    overrides.each do |group|
      puts "\n#{group[:label]} overrides"

      group[:files].each do |source_rel, target_rel|
        source = File.join(group[:source_root], source_rel)
        target = File.join(group[:target_root], target_rel)

        unless File.exist?(source)
          puts "Missing source file: #{source_rel}"
          next
        end

        FileUtils.mkdir_p(File.dirname(target))
        FileUtils.cp(source, target)

        puts "Copied #{group[:label]}: #{target_rel}"
      end
    end
  end

  def create_marker_file!
    marker_path = Rails.root.join('.newsmast_mastodon_installed')
    File.write(marker_path, <<~CONTENT)
      # This file indicates that newsmast_mastodon has been installed
      # Generated at: #{Time.current}
      # Do not delete this file unless you want to re-run the installation
    CONTENT
    puts "Created installation marker file: .newsmast_mastodon_installed"
  end
end
