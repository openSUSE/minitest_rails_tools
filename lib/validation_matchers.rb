# Allows for some automagic association tests.
# Expects 'subject' to be defined. E.g.
#   subject { FactoryGirl.create :foo }

def must_validate_presence_of(attribute, options = {})
  spec(__method__, attribute, options) do
    subject.send "#{attribute}=".to_sym, nil
    subject.wont_be :valid?
    message = options[:message] || "can't be blank"
    subject.errors.messages[attribute.to_sym].must_include message
  end
end

def must_validate_uniqueness_of(attribute, options = {})
  spec(__method__, attribute, options) do
    other = subject.class.new
    other.send "#{attribute}=".to_sym, subject.send(attribute)
    other.wont_be :valid?
    message = options[:message] || "has_already been taken"
    other.errors.messages[attribute.to_sym].must_include message
  end
end

def must_validate_length_of(attribute, options = {})
  spec(__method__, attribute, options) do
    if options[:minimum]
      subject.send "#{attribute}=".to_sym, (0..options[:minimum] - 1).to_a
      subject.wont_be :valid?
      message = options[:message] || "is too short (minimum is #{options[:minimum]}"
      subject.errors.messages[attribute.to_sym].must_include message
    end
    if options[:maximum]
      subject.send "#{attribute}=".to_sym, (0..options[:maximum] + 1).to_a
      subject.wont_be :valid?
      message = options[:message] || "is too long (maximum is #{options[:maximum]}"
      subject.errors.messages[attribute.to_sym].must_include message
    end
  end
end


private

def spec(name, attribute, options)
  title = "#{name.to_s[4..-1]} :#{attribute.to_s.parameterize.underscore}"
  title += options.to_s[1..-2].gsub('=>', ' => ') unless options.blank?
  it title do
    yield
  end
end
