# Allows for some automagic association tests.
# Expects 'subject' to be defined. E.g.
#   subject { FactoryGirl.create :foo }

def must_validate_presence_of(attribute_name, options = {})
  it "validates_presence_of :#{attribute_name.to_s.parameterize.underscore}" do
    subject.send "#{attribute_name}=".to_sym, nil
    subject.valid?.must_equal false
    message = options[:message] || "can't be blank"
    subject.errors.messages[attribute_name.to_sym].must_include message
  end
end

def must_validate_uniqueness_of(attribute_name, options = {})
  it "validates_uniqueness_of :#{attribute_name.to_s.parameterize.underscore}" do
    other = subject.class.new
    other.send "#{attribute_name}=".to_sym, subject.send(attribute_name)
    other.valid?.must_equal false
    message = options[:message] || "has_already been taken"
    other.errors.messages[attribute_name.to_sym].must_include message
  end
end
