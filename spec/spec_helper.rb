ENV["RAILS_ENV"] ||= 'test'

require 'stringio'

RSpec.configure do |config|
  config.before :each do
    $stdout = StringIO.new
  end

  config.after :all do
    $stdout = STDOUT
  end
end
