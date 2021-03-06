require 'rails_helper'
RSpec.describe 'Artist show page', type: :feature do
    before :each do
        @user1 = User.create(username: "Music McMusic", email: "music@hotmail.com", zipcode: "80210" )
        @artist_1 = Artist.create(followers: 2020, name: "Ramakhandra", description: "A very cool band", zipcode: "80216", spotify_id: "1Apw9xiab11PyZLo6YeUoJ", city: "Denver", state: "CO", genre: ["electronic", "psychedelic"])
        @artist_2 = Artist.create(followers: 2020, name: "Smirk", zipcode: "80126", spotify_id: "3pwiEWINB62yhDUUODnHLj", city: "Denver", state: "CO", genre: ["instrumental", "jazz"])
        @artist_3 = Artist.create(followers: 2020, name: "American Grandma", description: "A very cool band", zipcode: "80126", spotify_id: "4XTcP25C5ZUWpwf0NYGJnn", city: "Denver", state: "CO", genre: ["mellow"])
        @artist_4 = Artist.create(followers: 2020, name: "Oko Tygra", zipcode: "80126", spotify_id: "0K7C1TRrshf9PGeOmnwtDe", city: "Denver", state: "CO", genre: ["electronic"])
        @artist_5 = Artist.create(followers: 2020, name: "Nightmare Blue", zipcode: "80126", spotify_id: "e", city: "Denver", state: "CO", genre: ["rock", "garage-rock"])
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

        artist_albums = File.read('spec/fixtures/artist_albums.json')
        stub_request(:get, "https://api.spotify.com/v1/artists/1Apw9xiab11PyZLo6YeUoJ/albums").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>'Bearer',
        'User-Agent'=>'Faraday v1.0.1'
          }).
        to_return(status: 200, body: artist_albums, headers: {})

    end

    it 'Artist information is visible on the artist show page', :vcr do
      visit 'api/v1/user'

      expect(current_path).to eq("/api/v1/preferences")


      fill_in :zipcode, with: '61109'

      click_on "Update Preferences"

      expect(current_path).to eq("/api/v1/dashboard")

      visit "/artists/#{@artist_1.id}"

      within ".artist-name" do
        expect(page).to have_content(@artist_1.name)
      end

      within ".description" do
        expect(page).to have_content("A very cool band")
      end


      within ".links" do
        expect(page).to have_content("Earl Grey")
        expect(page).to have_content("The Eternal")
        expect(page).to have_content("Mudhouse")
      end

    end

end
