module MiniTest::Assertions

  def assert_count(value, list)
    size = list.size
    assert_equal value, size, "Expected size to be #{value}, but was #{size}"
  end

  def assert_same_elements(value, list)
    assert_equal(
      list.sort, value.sort,
      "Expected #{list} to have the same elements as #{value}"
    )
  end

  def assert_difference(expression, difference = 1, message = nil, &block)
    expressions = Array.wrap expression
    exps = expressions.collect do |e|
      e.respond_to?(:call) ? e : lambda { eval(e, block.binding) }
    end
    before = exps.collect(&:call)

    yield

    expressions.zip(exps).each_with_index do |(code, e), i|
      error  = "#{code.inspect} didn't change by #{difference}"
      error  = "#{message}.\n#{error}" if message
      assert_equal(before[i] + difference, e.call, error)
    end
  end

end

class Object

  include MiniTest::Assertions

  # Usage:
  # Foo.must_differ('count', -1) do
  #   delete :destroy, :id => foo.to_param
  # end
  def must_differ(expression, difference = 1, message = nil, &block)
    metaclass = class << self; self end
    metaclass.send(:define_method, :callback)
    assert_difference("#{self}.#{expression}", difference, message, &block)
  end

end

Object.infect_an_assertion :assert_count, :must_count
Object.infect_an_assertion :assert_count, :must_have_size
Array.infect_an_assertion :assert_same_elements, :must_have_same_elements_as
