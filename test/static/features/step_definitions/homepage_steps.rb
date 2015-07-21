Gegeven(/^dat er een aantal quotes zijn over Docker$/) do
  @player = create :player
end

Stel(/^dat ik de fantastische homepage bezoek$/) do
  visit '/'
end

Dan(/^zie ik een overzicht vanb alle quotes$/) do
  expect(page).to have_content @player.name
end

Dan(/^maken wij voor de test een screenshot met de naam "([^"]*)"$/) do |filename|
  save_screenshot "screenshots/#{filename}"
end