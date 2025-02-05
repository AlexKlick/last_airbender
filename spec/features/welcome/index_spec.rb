require 'rails_helper'

  RSpec.describe 'welcome index' do
    describe 'select field' do
      before (:each) do
        visit "/"
        select 'Fire Nation', from: 'nation'
        click_on('commit')
      end
      #     As a user,
      # When I visit "/"
      # And I Select "Fire Nation" from the select field
      # (Note: Use the existing select field)
      # And I click "Search For Members"
      # Then I should be on page "/search"
      # Then I should see the total number of people who live in the Fire Nation. (should be close to 100)
      it 'when making a selection, and submitting the search, the uri is now /search and the total number of people in the nation is shown' do
        expect(current_path).to eq('/search')
        within('#count') do
          expect(page).to have_content("Member Count: #{20}")
        end
      end
      # And I should see a list with the detailed information for the first 25 members of the Fire Nation.
      # - The name of the member (and their photo, if they have one)
      # - The list of allies or "None"
      # - The list of enemies or "None"
      # - Any affiliations that the member has
      it 'has the detailed info from the first 25 people' do
        #there were only 20 people in fire nation?
        @members = AirBenderFacade.get_nation_members('fire_nation')
        within('#detailed') do
          expect(page).to have_css('tr', count: 21)
          within('#Afiko') do
            expect( page.find('td:nth-of-type(1)').text).to eq("Afiko")
            expect( page.find('td:nth-of-type(4)').text).to eq("[\"Aang\"]")
            expect( page.find('td:nth-of-type(5)').text).to eq("Fire Nation")
          end
          within('#Chey') do
          expect( page.find('td:nth-of-type(1)').text).to eq("Chey")
          expect( page.find('td:nth-of-type(4)').text).to eq("[\"Fire Nation\"]")
          expect( page.find('td:nth-of-type(5)').text).to eq("Fire Nation Army (formerly)")
          end
          expect( page.find('tr:nth-of-type(10)').text).to eq("Azula's ship captain [\"Azula\"] [\"Iroh\"] Fire Nation Navy")
          expect( page.find('tr:nth-of-type(21)').text).to eq("Fire Nation bar patron's friend [\"Fire Nation bar patron\"] [\"Katara\"] Fire Nation")

        end
      end
  end
end