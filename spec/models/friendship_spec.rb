require 'rails_helper'

RSpec.describe Friendship, type: :model do

  it { should validate_presence_of :requester_id }
  it { should validate_presence_of :requestee_id }
  it { should belong_to :requester }
  it { should belong_to :requestee }

end
