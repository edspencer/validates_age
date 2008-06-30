# Include hook code here
require 'validates_age'
ActiveRecord::Base.class_eval { include ActiveRecord::Validations::ValidatesAge }