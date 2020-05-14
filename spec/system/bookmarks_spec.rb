# frozen_string_literal: true
# require 'rails_helper'

# RSpec.describe 'Bookmarks', type: :system do

#   let(:user) { FactoryBot.create(:user) }
#   let(:other_user) { FactoryBot.create(:other_user) }
#   let(:article) { FactoryBot.create(:article) }

#   describe "bookmark in timeline", js: true do

#     context "user bookmarks own article" do
#       it "bookmarks/unbookmark an article" do
#         # sign_in_as user
#         # post_new_article

#         # expect(find_by_id("bookmark-number")).to have_content "0"

#         # find_by_id('bookmark-btn').click

#         # save_and_open_page
#         # expect(find_by_id('bookmark-number')).to have_content "1"
#         # expect(page).to_not have_selector('#bookmark-btn')

#         # find_by_id('unbookmark-btn').click

#         # wait_for_ajax do
#         #   expect(find_by_id('bookmark-number')).to have_content "0"
#         #   expect(page).to_not have_selector('#unbookmark-btn')
#         end
#       end
#     end

#     context "other_user bookmarks user's article" do
#       it "shows correct counts" do
#         # sign_in_as user
#         # post_new_article
#         # sign_out

#         # sign_in_as other_user
#         # visit user_path(user)

#         # find_by_id('bookmark-btn').click

#         # wait_for_ajax do
#         #   expect(find_by_id('bookmark-number')).to have_content "1"
#         #   expect(page).to_not have_selector('#bookmark-btn')
#         # end

#         # sign_out

#         # sign_in_as user
#         # expect(find_by_id('bookmark-number')).to have_content "1"
#         # expect(page).to have_selector('#bookmark-btn')

#       end
#     end
#   end

#   describe "show_bookmark page" do
#     it "shows view as expected" do

#     end
#   end
# end
