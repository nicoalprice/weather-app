require 'yahoo_weatherman'

# User inputs zipcode.

puts "What is your zipcode?"
zipcode = gets.chomp

# Need to figure out how to simplify code by using this method
#def get_location(zipcode)
 #   client = Weatherman::Client.new
 #   client.lookup_by_location(zipcode)
#end

# Convert temperature from C to F. Thanks to Skillcrush classmate Mary Huynh.

def temp_converter(temp)
    temp = temp * 1.8 + 32
    return temp.to_i
end

# Accept location as parameter and use weather gem to display the current temperature (in Fahrenheit) and conditions for that location.


def current_weather(zipcode)
    client = Weatherman::Client.new
    client.lookup_by_location(zipcode)
    
    temperature = temp_converter(client.lookup_by_location(zipcode).condition['temp'])
    conditions = client.lookup_by_location(zipcode).condition['text'].downcase
    puts "The current weather for #{zipcode} is #{temperature} degrees Fahrenheit and #{conditions}."
end

# Find and display 5 day forecast

def weather_forecast(zipcode)
    client = Weatherman::Client.new
    client.lookup_by_location(zipcode)
    
    today = Time.now.strftime('%w').to_i
    
    client.lookup_by_location(zipcode).forecasts.each do |forecast|
        
        day = forecast['date']
 
        weekday = day.strftime('%w').to_i
 
            if weekday == today
                dayName = 'Today'
            elsif weekday == today + 1
                dayName = 'Tomorrow'
            else
                dayName = day.strftime('%A')
            end
 
        puts dayName + ' is going to be ' + forecast['text'].downcase + ' with a low of ' + temp_converter(forecast['low']).to_s + ' and a high of ' + temp_converter(forecast['high']).to_s + "."
    end

end
puts "Forecast for #{zipcode}:\n" 
weather_forecast(zipcode)

