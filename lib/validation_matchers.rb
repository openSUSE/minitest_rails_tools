# Allows for some automagic association tests.
# Expects 'subject' to be defined. E.g.
#   subject { FactoryGirl.create :foo }

def must_validate_presence_of(attribute, options = {})
  spec(__method__, attribute, options, "can't be blank", nil)
end

def must_validate_uniqueness_of(attribute, options = {})
  spec(__method__, attribute, options, "has already been taken", :not_uniq) do
    other_instance = self.to_s.rstrip.constantize.new
    other_instance.send "#{attribute}=".to_sym, :not_uniq
    other_instance.save!(:validate => false)
  end
end

def must_validate_length_of(attribute, options = {})
  if options[:minimum]
    spec(
      __method__, attribute, options.except(:maximum),
      "is too short (minimum is #{options[:minimum]}", (0..options[:minimum] - 1).to_a
    )
  end
  if options[:maximum]
    spec(
      __method__, attribute, options.except(:minimum),
      "is too long (maximum is #{options[:maximum]}", (0..options[:maximum] + 1).to_a
    )
  end
end


private

def spec(name, attribute, options, default_message, value)
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
