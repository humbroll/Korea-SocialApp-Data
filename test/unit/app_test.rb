require 'test_helper'

class AppTest < ActiveSupport::TestCase
  test "should not be duplicated" do 
    @app = App.new(:name => "app1", :appId => 632, :author => "odniel", :description =>"contents", :category => "quiz/test", :birthday => "2010-01-14", :platform => "nate", :created_at => "2011-04-18 16:30:18", :updated_at => "2011-04-18 16:30:18")
    @app2 = App.new(:name=>"app2", :appId => 632, :author => "odniel", :description =>"contents", :category => "quiz/test", :birthday => "2010-01-14", :platform => "nate", :created_at => "2011-04-18 16:30:18", :updated_at => "2011-04-18 16:30:18")
    
    @app.save!
    assert !@app2.valid?, "appId #{@app.appId} is duplicated!"
  end
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