class App < ActiveRecord::Base
  has_many :ranks
  
  scope :nate, :conditions => {:platform => "nate"}
  scope :naver, :conditions => {:platform => "naver"}
end
