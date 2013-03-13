class HelperProxy

  attr_accessor :current_methods

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
end


module HelperExtension

  def helper(name)
    HelperProxy.new(name)
  end

end
