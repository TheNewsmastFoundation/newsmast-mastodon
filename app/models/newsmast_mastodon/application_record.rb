module NewsmastMastodon
  class ApplicationRecord < (defined?(::ApplicationRecord) ? ::ApplicationRecord : ActiveRecord::Base)
    self.abstract_class = true
  end
end
