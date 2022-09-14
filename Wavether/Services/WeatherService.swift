//
//  WeatherService.swift
//  Wavether
//
//  Created by Maciej on 13/09/2022.
//

import Foundation

class WeatherService {
    let apiKey = "d34574faffa9ee24e173a6f68a3b7689"
    let lat = 54.258389
    let lon = 18.649059
    let unit = "metric"
    
    func getWeather(longtitude: Double, latitude: Double) async throws -> ResponseBody{
        //    https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid=d34574faffa9ee24e173a6f68a3b7689
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&units=\(unit)&exclude=minutely&appid=\(apiKey)") else { fatalError("Wrong URL.") }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data.") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
    
    struct Current: Codable {
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        let dt: Date
        let sunrise: Date
        let sunset: Date
        let temp: Double
        let feelsLike: Double
        let pressure: Int
        let humidity: Int
        let dewPoint: Double
        let uvi: Double
        let clouds: Int
        let visibility: Int
        let windSpeed: Double
        let windDeg: Int
        let weather: [Weather]
        
        private enum CodingKeys: String, CodingKey {
            case dt
            case sunrise
            case sunset
            case temp
            case feelsLike = "feels_like"
            case pressure
            case humidity
            case dewPoint = "dew_point"
            case uvi
            case clouds
            case visibility
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case weather
        }
    }
    
    struct Hourly: Codable {
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Rain: Codable {
            let _1h: Double
            
            private enum CodingKeys: String, CodingKey {
                case _1h = "1h"
            }
        }
        
        let dt: Date
        let temp: Double
        let feelsLike: Double
        let pressure: Int
        let humidity: Int
        let dewPoint: Double
        let uvi: Double
        let clouds: Int
        let visibility: Int
        let windSpeed: Double
        let windDeg: Int
        let windGust: Double
        let weather: [Weather]
        let pop: Double
        let rain: Rain?
        
        private enum CodingKeys: String, CodingKey {
            case dt
            case temp
            case feelsLike = "feels_like"
            case pressure
            case humidity
            case dewPoint = "dew_point"
            case uvi
            case clouds
            case visibility
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
            case weather
            case pop
            case rain
        }
    }
    
    struct Daily: Codable {
        struct Temp: Codable {
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        
        struct FeelsLike: Codable {
            let day: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        let dt: Date
        let sunrise: Date
        let sunset: Date
        let moonrise: Date
        let moonset: Date
        let moonPhase: Double
        let temp: Temp
        let feelsLike: FeelsLike
        let pressure: Int
        let humidity: Int
        let dewPoint: Double
        let windSpeed: Double
        let windDeg: Int
        let windGust: Double
        let weather: [Weather]
        let clouds: Int
        let pop: Double
        let uvi: Double
        let rain: Double?
        
        private enum CodingKeys: String, CodingKey {
            case dt
            case sunrise
            case sunset
            case moonrise
            case moonset
            case moonPhase = "moon_phase"
            case temp
            case feelsLike = "feels_like"
            case pressure
            case humidity
            case dewPoint = "dew_point"
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
            case weather
            case clouds
            case pop
            case uvi
            case rain
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
        case hourly
        case daily
    }
}
