module CommentSteps

  def create_new_comment_with(body)
	fill_in "com-form-1", with: body
	click_button "Comment"
  end

  def i_should_see_the_new_comment(body)
	expect(page.find('.posts')).to have_text(body)
  end

end
