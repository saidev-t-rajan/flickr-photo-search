require 'rails_helper'

describe "Photos page" do

  it "should have search box" do
    visit root_path

    expect(page).to have_content('Search Flickr for photos')
    expect(page).to have_css('input[type="text"]')
    expect(page).to have_css('input[type="submit"]')
  end

  it "should show 12 photos when searched" do
    visit root_path

    fill_in 'search', with: "lake"
    click_button "Search"

    expect(page).to have_selector('.thumbnail', count: 12)
    expect(page.first('.thumbnail')).to have_xpath("//img")
  end

  it "should have pagination" do
    visit root_path

    fill_in 'search', with: "lake"
    click_button "Search"

    expect(page).to have_selector('div.pagination')
  end

  it "should set modal src to larger image url when thumbnail is clicked on", :js do
    visit root_path

    fill_in 'search', with: "lake"
    click_button "Search"

    first("img").click

    expect(first(".thumbnail")['data-imgpath']).to eq(find(".modal-dialog").find("img")['src'])
  end
end