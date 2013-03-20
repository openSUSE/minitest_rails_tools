# Allows for some automagic association tests.
# Expects 'subject' to be defined. E.g.
#   subject { FactoryGirl.create :foo }

def must_validate_presence_of(attribute, options = {})
  spec(subject, __method__, attribute, options, "can't be blank", nil)
end

def must_validate_uniqueness_of(attribute, options = {})
  spec(subject.dup, __method__, attribute, options, "has_already been taken", subject.send(attribute))
end

def must_validate_length_of(attribute, options = {})
  if options[:minimum]
    spec(
      subject, __method__, attribute, options.except(:maximum),
      "is too short (minimum is #{options[:minimum]}", (0..options[:minimum] - 1).to_a
    )
  end
  if options[:maximum]
    spec(
      subject, __method__, attribute, options.except(:minimum),
      "is too long (maximum is #{options[:maximum]}", (0..options[:maximum] + 1).to_a
    )
  end
end


private

def spec(subject, name, attribute, options, default_message, value)
  title = "#{name.to_s[4..-1]} :#{attribute.to_s.parameterize.underscore}"
  title += options.to_s[1..-2].gsub('=>', ' => ') unless options.blank?
  it title do
    yield if block_given?
    subject.send "#{attribute}=".to_sym, value
    subject.wont_be :valid?
    message = options[:message] || default_message
    subject.errors.messages[attribute.to_sym].must_include message
  end
end
