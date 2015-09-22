require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
	@valid_user   = users(:example)
	@invalid_user = users(:invalid_example)
  end

  test "User should be valid" do
    
  end
end
