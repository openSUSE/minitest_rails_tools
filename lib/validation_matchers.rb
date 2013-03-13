# Allows for some automagic association tests.

def must_validate_presence_of(attribute_name)
  it "validates_presence_of :#{attribute_name.to_s.parameterize.underscore}" do
    subject.send "#{attribute_name}=".to_sym, nil
    subject.valid?.must_equal false
    subject.errors.messages[attribute_name.to_sym].must_include "can't be blank"
  end
end

def must_validate_uniqueness_of(attribute_name)
  it "validates_uniqueness_of :#{attribute_name.to_s.parameterize.underscore}" do
    other = FactoryGirl.create subject.class.to_s.parameterize.underscore.to_sym
    subject.send "#{attribute_name}=".to_sym, other.send(attribute_name)
    subject.valid?.must_equal false
    subject.errors.messages[attribute_name.to_sym].must_include "has already been taken"
  end
end
