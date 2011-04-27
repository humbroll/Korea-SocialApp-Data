require 'test_helper'

class RankTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

