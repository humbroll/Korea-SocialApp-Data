class Rank < ActiveRecord::Base
  belongs_to :app

  scope :hot, :conditions => ["orderType IN (?)", ["1", "POPULARITY"]] #popularity
  scope :install, :conditions => ["orderType IN (?)", ["2", "INSTALL"]]
  
  
  scope :term, lambda{ |*args| { #e.g. App.find.first.scope(1.weeks.ago, Time.now)
    :conditions =>["created_at > ? and created_at < ? ", (args.first || 2.weeks.ago),(args.second || Time.now) ]
  } }
  
end
# == Schema Information
#
# Table name: ranks
#
#  id            :integer(4)      not null, primary key
#  rank          :integer(4)
#  orderType     :string(255)
#  rating        :float
#  downloadCount :integer(4)
#  app_id        :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

