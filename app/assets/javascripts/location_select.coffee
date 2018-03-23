
console.log ($ '*').hasClass ".location-select-country"

$('*').each  (i,de)->
  console.log de

location_select = $ '.location-select'


if location_select

  alert ($ '#location-select-country').hasClass 'location-select-country'

  country_select  = $ '.location-select-country'
  if country_select

    country_select.options[country_select.length] = new Option 'Загружаем', 1, true, true
    country_select.load ->
      $.get '/getAll_countries_path', {}, onGetCountries, "json"
    onGetCountries = (data)->
      country_select.clear()
      country_select.length = data.length
      for c in data
        country_select.options.add new Option(c.name, c.id)

    region_select   = $('.location-select-region')
    city_select     = $('.location-select-city')

