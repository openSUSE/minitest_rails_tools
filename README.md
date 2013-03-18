# Minitest Rails Tools


This is a collection of little helpers to make working with Rails and Minitest a bit easier.

_NOTE: This is a work in progress. I'm using this gem in two of my applications and I'm going to continue to add stuff to it, as well as fixing bugs._


## Installation

To install this gem, just put it in your `Gemfile`:

    group :test do
      gem 'minitest', :require => false
      gem 'minitest_rails_tools', :require => false
    end

Afterwards require it in your `test_helper.rb`:

    require 'minitest/autorun'
    require 'minitest_rails_tools'

Alternatively, you could also just require certain parts of the tools:

    require 'minitest/autorun'
    require 'association_matchers'
    require 'validation_matchers'
    require 'helper_extension'


## Tools

### Association Matchers

This allows you to test standard Rails associations in your tests:

    subject { FactoryGirl.create :foo }
    
    must_belong_to :faz
    must_have_one :boo
    must_have_many :bams
    must_have_many_through :bars, :bams
    must_have_and_belong_to_many :berks


### Validation Matchers

You may use this to test a couple of Rails' validations in your tests:

    subject { FactoryGirl.create :foo }
    
    must_validate_presence_of :bar
    must_validate_uniqueness_of :baz


### Helper Extension

This allows you to define a helper as your subject (and then call your helper methods on it):

    subject { helper :foo_helper }
    
    subject.do_my_stuff.must_equal 'OK'



Copyright © 2013 SUSE released under the MIT license. For full details see LICENSE included in this distribution.
