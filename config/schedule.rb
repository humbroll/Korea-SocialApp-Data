# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 1.day, :at => '00:05 am' do 
  runner "/Users/humbroll/workspace/Project/nhn/appdata/app/runner/appRankCrawler", :environment => :production
  #e.g. runner "/home/humbroll/workspace/mentalArithmetic/app/runner/deleteWithdrawalUser", :environment => :production  
end