# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def fillLocations

  tabChar = "\t"

  locsFile = open "app/assets/data generation/locations"

  curCountry = curRegion = nil

  while line = locsFile.gets
    tabCount = 0
    line.size.times do |i|
      if line[i] == tabChar
        tabCount+=1
      else break end
    end
    name = line.strip
    puts "name: " + name
    if tabCount == 0
      sameNameCountry = Country.find_by_name(name)
      if sameNameCountry
        curCountry = sameNameCountry
      else
        curCountry = Country.create { |c| c.name =  name}
        puts "add country"
      end
      puts "set current Country = " + curCountry.name
    elsif tabCount == 1
      sameNameRegion = Region.find_by({:name => name, :country => curCountry })
      if sameNameRegion
        curRegion = sameNameRegion
        puts "add region"
      else
        curRegion = Region.create { |r| r.name = name; r.country_id = curCountry.id}
      end
      puts "set current Region = " + curRegion.name
    elsif tabCount == 2
      sameNameCity = City.find_by({:name => name, :region => curRegion})
      if sameNameCity
      else
        City.create {|c| c.name = name; c.region_id = curRegion.id}
        puts "add city"
      end
    end
  end
  locsFile.close
end

def fillCamps

  splitChar = ";"
  campNamesFile = open "app/assets/data generation/camp names"

  nameParts_1 = []
  nameParts_2 = []
  while line = campNamesFile.gets
    nameParts = line.strip().split(splitChar)
    puts "readed = " + nameParts[0].to_s + " 2: " + nameParts[1].to_s
    nameParts_1 << nameParts[0] if nameParts[0]
    nameParts_2 << nameParts[1] if nameParts[1]
  end
  puts "np1 " + nameParts_1.to_s
  puts "np2 " + nameParts_2.to_s
  campNamesFile.close

  campDescriptionsFile = open "app/assets/data generation/camp descriptions"

  descriptionParts = []
  5.times { descriptionParts.append [] }
  puts descriptionParts.to_s

  while line = campDescriptionsFile.gets
    parts = line.strip().split(splitChar)
    parts.size.times do |i|
      puts descriptionParts.to_s + " | " + parts[i].to_s
      descriptionParts[i] << parts[i].gsub("_"," ") if parts[i]
    end
  end
  campDescriptionsFile.close


  minCityId = City.minimum :id
  maxCityId = City.maximum :id

  200.times do ||
    name = nameParts_1[rand nameParts_1.size] + " " + nameParts_2[rand nameParts_2.size]

    description = ""
    for descrParts in descriptionParts
      description += descrParts[rand descrParts.size] + " "
    end

    randId = minCityId + rand(maxCityId-minCityId+1)
    puts "randId: " + randId.to_s
    while ! (randCity = City.find( randId) )
      randId = minCityId + rand(maxCityId-minCityId+1)
    end

    Camp.create do |c|
      c.name = name
      c.description = description
      c.city_id = randCity.id
      puts "create camp with name: " + c.name + " dicr: " + c.description + " city: " + randCity.name
    end

  end

end

fillLocations
fillCamps
