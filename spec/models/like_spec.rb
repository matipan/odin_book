require 'rails_helper'

RSpec.describe Like, type: :model do

  it { should belong_to :user }
  it { should belong_to :post }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :post_id }

end
