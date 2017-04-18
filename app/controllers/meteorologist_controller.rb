require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    geo = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address
    parsed_geo = JSON.parse(open(geo).read)

    @lat = parsed_geo["results"][0]["geometry"]["location"]["lat"].to_s

    @long = parsed_geo["results"][0]["geometry"]["location"]["lng"].to_s

    weather = "https://api.darksky.net/forecast/ed26ae7ac5a17f21ccc312ea2160f5b5/"+@lat+","+@long
    parsed_weather = JSON.parse(open(weather).read)


    @current_temperature = parsed_weather["currently"]["temperature"]

    @current_summary = parsed_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weather["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
