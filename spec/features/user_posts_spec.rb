require 'spec_helper'

feature 'User posts' do
  [:user, :admin].each do |role|
    scenario "a topic as #{role}" do
      forum = create :forum
      user = sign_in(role)

      visit forum_path(forum)
      page.all(:xpath, "//a[@href='#{new_topic_path(forum_id: forum.id)}']").first.click
      fill_in 'Title', with: 'Hello'
      fill_in 'Message', with: 'Check me'
      click_on 'Create Topic'
      page.should have_content('Hello')
      page.should have_content(user.name)
      page.should have_content('Check me')
    end

    scenario "a message as #{role}" do
      topic = create :topic
      user = sign_in(role)

      visit topic_path(topic)
      fill_in 'Message', with: 'Check me'
      click_on 'Create Message'
      page.should have_content(user.name)
      page.should have_content('Check me')
    end

    scenario "a small_message as #{role}" do
      topic = create :topic
      user = sign_in(role)

      visit topic_path(topic)
      fill_in 'small_message_content', with: 'Hi!'
      click_on 'Create Small message'
      page.should have_content(user.name)
      page.should have_content('Hi!')
    end
  end
end
