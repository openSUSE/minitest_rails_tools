require 'minitest/autorun'

# Allows for some automagic association tests.

def must_belong_to(association_name)
  it "belongs_to :#{association_name.to_s.parameterize.underscore}" do
    subject.association(association_name).must_be_kind_of(ActiveRecord::Associations::BelongsToAssociation)
    subject.send(association_name)
  end
end

def must_have_one(association_name)
  it "has_one :#{association_name.to_s.parameterize.underscore}" do
    subject.association(association_name).must_be_kind_of(ActiveRecord::Associations::HasOneAssociation)
    subject.send(association_name)
  end
end

def must_have_many(association_name)
  it "has_many :#{association_name.to_s.parameterize.underscore}" do
    subject.association(association_name).must_be_kind_of(ActiveRecord::Associations::HasManyAssociation)
    subject.send(association_name).must_be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end
end

def must_have_many_through(association_name, association_name_through)
  it "has_many :#{association_name.to_s.parameterize.underscore} through :#{association_name_through.to_s.parameterize.underscore}" do
    subject.association(association_name).must_be_kind_of(ActiveRecord::Associations::HasManyThroughAssociation)
    subject.send(association_name).must_be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end
end

def must_have_and_belong_to_many(association_name)
  it "has_and_belongs_to_many :#{association_name.to_s.parameterize.underscore}" do
    subject.association(association_name).must_be_kind_of(ActiveRecord::Associations::HasAndBelongsToManyAssociation)
    subject.send(association_name).must_be_kind_of(ActiveRecord::Associations::CollectionProxy)
  end
end
