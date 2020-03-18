## Travel Bucket List

Build an app to track someone's travel adventures.

### MVP:

 * The app should allow the user to track countries and cities they want to visit and those they have visited.
 * The user should be able to create and edit countries
 * Each country should have one or more cities to visit
 * The user should be able to create and delete entries for cities
 * The app should allow the user to mark destinations as visited or still to see

### Possible Extensions:

 * Have separate pages for destinations visited and those still to visit
 * Add sights to the destination cities
 * Search for destination by continent, city or country
 * Any other ideas you might come up with
 
 Running instructions for this Application
 
 You will need PG gem and sinatra gem to run this application. 
 
 1. After cloning the data base from gut hub. Run command: createdb travel_tracker (You may need to run: dropdb travel_tracker) If you think you may have an exisiting database with same name.
 2. Run command: psql -d travel_tracker -f db/travel_tracker.sql
 3. Run command: ruby seeds.rb (This generates the list of countries)
 4. Run command: ruby app.rb
 5. Open your browser of choice and go to http://localhost:4567/ or if you have changed your default sinatra port use that instead.

