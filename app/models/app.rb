class App < ActiveRecord::Base
  has_many :ranks
  
  named_scope :nate, :conditions => {:platform => "nate"}
  named_scope :naver, :conditions => {:platform => "naver"}
end
