require 'minitest/autorun'

class MiniTest::Spec
  include Rails.application.routes.url_helpers
end

class ControllerSpec < MiniTest::Spec

  require 'rails/test_help'

  alias :method_name :__name__ if defined? :__name__

  include ActiveSupport::Testing::SetupAndTeardown
  include ActiveSupport::Testing::Assertions
  include ActionController::TestCase::Behavior

end
# Functional tests = describe ***Controller
MiniTest::Spec.register_spec_type( /Controller$/, ControllerSpec )