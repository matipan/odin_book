require 'rails_helper'
require 'support/login_steps'
require 'support/post_steps'
require 'support/comment_steps'

RSpec.feature "CommentManagments", type: :feature do
  include LoginSteps
  include PostSteps
  include CommentSteps

  let(:matias) { create :user }

  before :example do
    login_with(matias)
	create_new_post_with("hello world hello world")
  end

  describe "comments creation" do
	context 'when a user submits a valid comment' do
      it 'adds the comment to the specified post' do
        create_new_comment_with("This is some comment")
		i_should_see_the_new_comment("This is some comment")
      end
    end
  end


end
