class HelperExtension

  include ActionView::Helpers

 attr_accessor :current_methods, :output_buffer

  def initialize(name)
    @current_methods ||= []
    # Remove existing instance methods.
    @current_methods.each do |method_name|
      self.class.send(:remove_method, method_name)
    end
    # Add new instance methods from helper module.
    klass = name.to_s.camelize.safe_constantize
    @current_methods = klass.instance_methods
    self.class.send(:include, klass)
  end

  # We don't need this protection in our tests.
  def protect_against_forgery?
    false
  end

end

def helper(name)
  HelperExtension.new(name)
end
