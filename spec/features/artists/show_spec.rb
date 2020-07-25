require 'rails_helper'
RSpec.describe 'Artist show page', type: :feature do 
    before :each do 
        @user1 = User.create(username: "Music McMusic", email: "music@hotmail.com", zipcode: "80210" )
        @artist_1 = Artist.create(name: "Ramakhandra", description: "A very cool band", zipcode: "80216", spotify_id: "1Apw9xiab11PyZLo6YeUoJ", city: "Denver", state: "CO", genre: ["electronic", "psychedelic"])
        @artist_2 = Artist.create(name: "Smirk", zipcode: "80126", spotify_id: "3pwiEWINB62yhDUUODnHLj", city: "Denver", state: "CO", genre: ["instrumental", "jazz"])
        @artist_3 = Artist.create(name: "American Grandma", description: "A very cool band", zipcode: "80126", spotify_id: "4XTcP25C5ZUWpwf0NYGJnn", city: "Denver", state: "CO", genre: ["mellow"])
        @artist_4 = Artist.create(name: "Oko Tygra", zipcode: "80126", spotify_id: "0K7C1TRrshf9PGeOmnwtDe", city: "Denver", state: "CO", genre: ["electronic"])
        @artist_5 = Artist.create(name: "Nightmare Blue", zipcode: "80126", spotify_id: "e", city: "Denver", state: "CO", genre: ["rock", "garage-rock"])
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end 
    
    it 'Artist information is visible on the artist show page' do 
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