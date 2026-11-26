# frozen_string_literal: true

# Run with the host app's runner:
#   bin/rails runner /path/to/script/ci/reset_gem_migrations.rb
# then run `bin/rails db:migrate`.
#
# When a fresh database is created from the host's db/schema.rb (db:prepare or
# db:schema:load), Rails records every migration older than the schema version
# as already run, including this gem's migrations, so their tables and columns
# are never created. This removes the gem's versions from schema_migrations so
# the next db:migrate runs them. The gem's migrations are written to be safe to
# re-run (if_not_exists / column_exists? guards).

migration_dirs = NewsmastMastodon::Engine.paths["db/migrate"].existent
versions = migration_dirs.flat_map { |dir| Dir[File.join(dir, "*.rb")] }
                         .filter_map { |file| File.basename(file)[/\A\d+/] }

abort("No newsmast_mastodon migrations found in #{migration_dirs.inspect}") if versions.empty?

connection = ActiveRecord::Base.connection
quoted = versions.map { |version| connection.quote(version) }.join(", ")
deleted = connection.delete("DELETE FROM schema_migrations WHERE version IN (#{quoted})")

puts "Cleared #{deleted} of #{versions.size} newsmast_mastodon migration version(s); run db:migrate next."
