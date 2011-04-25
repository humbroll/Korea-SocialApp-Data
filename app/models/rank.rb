class Rank < ActiveRecord::Base
  belongs_to :app

  scope :install, :conditions => ["orderType IN (?)", ["1", "INSTALL"]]
  scope :hot, :conditions => ["orderType IN (?)", ["2", "POPULARITY"]] #popularity
  
  scope :term, lambda{ |*args| { #e.g. App.find.first.scope(1.weeks.ago, Time.now)
    :conditions =>["created_at > ? and created_at < ? ", (args.first || 2.weeks.ago),(args.second || Time.now) ]
  } }
  
end