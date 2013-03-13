# Minitest-Rails-Tools


This is a collection of little helpers to make working with Rails and Minitest a bit easier.

NOTE: This is definitely a work in progress. I use this gem in two of my applications and will continue to add stuff to it, as well as fixing bugs.


It allows you to write stuff like this in your Minitest Spec:


    subject { FactoryGirl.create :foo }
    
    must_belong_to :faz
    must_have_one :boo
    must_have_many :bams
    must_have_many_through :bars, :bams
    must_have_and_belong_to_many :berks
    
    must_validate_presence_of :lol
    must_validate_uniqueness_of :lol

Additionally, you can define a helper as your subject:

    subject { helper :foo_helper }


Copyright © 2013 SUSE released under the MIT license. For full details see LICENSE included in this distribution.
