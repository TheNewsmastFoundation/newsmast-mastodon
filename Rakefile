require "bundler/setup"


APP_RAKEFILE = File.expand_path("spec/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  # rspec is a development dependency; ignore if unavailable.
end

desc "Run the Postman collection with Newman"
task :postman do
	sh "bash script/api/run_newman_suite.sh"
end

namespace :api do
  desc "Verify that routes, controllers, and Postman collections are in sync"
  task :verify do
    sh "ruby script/api/verify_routes_and_docs.rb"
  end

  desc "Generate tmp/newman.generated.env.json from live API responses"
  task :postman_setup do
    sh "ruby script/api/postman_setup.rb"
  end

  desc "Run all Postman collections via Newman"
  task :postman do
    sh "bash script/api/run_newman_suite.sh"
  end

  desc "Run request spec smoke suite"
  task :smoke do
    sh "bash script/api/run_rspec_smoke.sh"
  end

  desc "Run route/docs verification + Postman suite + request spec smoke suite"
  task full_check: [:verify, :postman, :smoke]
end
