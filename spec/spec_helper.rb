# Require all the things
require File.expand_path('suds_server');

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end