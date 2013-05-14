# Minitest Rails Tools


This is a collection of little helpers to make working with Rails and Minitest a bit easier.


## Installation

To install this gem, just put it in your `Gemfile`:

    group :test do
      gem 'minitest_rails_tools', :require => false
    end

Afterwards require it in your `test_helper.rb`:

    require 'minitest_rails_tools'

Alternatively, you could also just require certain parts of the tools.
See the respective section for the command to add only a specific part.

In order to get rid of TestUnit, just open your `application.rb` and change
the following lines:

    # Pick the frameworks you want:
    # require 'rails/all'
    require "active_record/railtie"
    require "action_controller/railtie"
    require "action_mailer/railtie"
    require "active_resource/railtie"
    require "sprockets/railtie"
    # require "rails/test_unit/railtie"

For generators to use MiniTest instead of TestUnit (additionally) change this:

    config.generators do |g|
      g.test_framework :mini_test, :spec => true, :fixture => true
    end


## Tools

### Application Integration

Adds Rails' routes URL helpers and registers ControllerSpecs. Just put the
controller name into the describe title:

    describe 'FooController' do

      let(:bam) { 42 }

      it 'does generic stuff' do
        get :bar, :zer => bam
        response.message.must_equal("OK")
      end

    end

This functionality is separately available by adding:

    require 'minitest_rails_tools/application_integration'


### Association Matchers

This allows you to test standard Rails associations in your tests:

    subject { FactoryGirl.create :foo }

    must_belong_to :faz
    must_have_one :zer
    must_have_many :bams
    must_have_many_through :bars, :bams
    must_have_and_belong_to_many :berks

This functionality is separately available by adding:

    require 'minitest_rails_tools/association_matchers'


### Expectations

This adds a couple of extra expectations to improve readability:

    Bar.must_differ('count', -1) do
      delete :destroy, :id => subject.to_param
    end

    subject.foos.must_have_size 20

    subject.foos.must_have_same_elements_as Foo.all

This functionality is separately available by adding:

    require 'minitest_rails_tools/expectations'


### Helper Extension

This allows you to define a helper as your subject (and then call your helper
methods on it):

    subject { helper :foo_helper }

    subject.do_my_stuff.must_equal 'OK'

This functionality is separately available by adding:

    require 'minitest_rails_tools/helper_extension'


### Validation Matchers

You may use this to test a couple of Rails' validations in your tests:

    subject { FactoryGirl.create :foo }

    must_validate_presence_of :bar
    must_validate_uniqueness_of :baz
    must_validate_length_of :zer, :minimum => 2, :maximum => 5

This functionality is separately available by adding:

    require 'minitest_rails_tools/validation_matchers'


Copyright © 2013 SUSE released under the MIT license.
For full details see LICENSE included in this distribution.
