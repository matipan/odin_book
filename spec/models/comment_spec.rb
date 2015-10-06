require 'rails_helper'

RSpec.describe Comment, type: :model do

  it { should belong_to :user }
  it { should belong_to :post }
  it { should validate_length_of(:body).is_at_most(1000) }
  it { should validate_length_of(:body).is_at_least(2) }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :post_id }

end
