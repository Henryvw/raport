require 'raport/concerns/controllers/reportify'

module Raport
  class Engine < ::Rails::Engine
    isolate_namespace Raport
    
    config.to_prepare do
      ApplicationController.helper(Raport::ApplicationHelper)
    end
      
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
    
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
