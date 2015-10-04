module PostSteps

  def i_should_see_the_new_post(body)
	create_new_post_with(body)
	expect(page.find(".posts")).to have_text(body)
  end

  def create_new_post_with(body)
	fill_in "post-body", with: body
	click_button "Post"
  end

end
