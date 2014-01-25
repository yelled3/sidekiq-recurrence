def initialize_testing_environment
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  require 'rspec'

  RSpec.configure do |config|

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

  end
end

require 'spork'

# check if spork listener is active
if Spork.using_spork?

  require 'spork/ext/ruby-debug'

  Spork.prefork do
    initialize_testing_environment
    # Spork ActiveRecord Hacks
  end

  Spork.each_run do

    #We want spork to refresh all the lib directory for each run so we won't have to reload guard
    Dir["#{Rails.root}/lib/**/*.rb"].each do |file|
      load file
    end

  end

else
  initialize_testing_environment
end