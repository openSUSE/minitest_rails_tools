class MiniTest::Spec

  require 'rails/test_help'

  alias :method_name :__name__ if defined? :__name__

  include Rails.application.routes.url_helpers
  include ActiveSupport::Testing::SetupAndTeardown
  include ActiveSupport::Testing::Assertions
  include ActionController::TestCase::Behavior

  before do
    @routes = Rails.application.routes
  end

end
