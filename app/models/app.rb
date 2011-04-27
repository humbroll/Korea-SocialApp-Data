class App < ActiveRecord::Base
  validates_uniqueness_of :appId
  has_many :ranks
  
  scope :nate, :conditions => {:platform => "nate"}
  scope :naver, :conditions => {:platform => "naver"}
end

# == Schema Information
#
# Table name: apps
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  appId       :integer(4)
#  author      :string(255)
#  description :text
#  category    :string(255)
#  birthday    :date
#  platform    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

