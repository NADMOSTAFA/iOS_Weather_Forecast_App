//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Apple on 18/05/2024.
//
import Foundation

// MARK: - ApiResponse
struct ApiResponse: Codable {
    let location: Location?
    let current: Current?
    var forecast: Forecast?
}

// MARK: - Current
struct Current: Codable {
    let lastUpdated: String?
    let tempC: Double?
    let condition: Condition?
    let pressureMB, pressureIn: Double?
    let humidity, feelslikeC: Double?
    let visKM: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case condition
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case humidity
        case feelslikeC = "feelslike_c"
        case visKM = "vis_km"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String?
    let icon: String?
}

// MARK: - Forecast
struct Forecast: Codable {
    var forecastday: [Forecastday]?
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String?
    let day: Day?
    let astro: Astro?
    var hour: [Hour]?

    enum CodingKeys: String, CodingKey {
        case date
        case day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Codable {
    let sunrise, sunset: String?
    let isMoonUp, isSunUp: Int?

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

// MARK: - Day
struct Day: Codable {
    let maxtempC, mintempC: Double?
    let condition: Condition?
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

// MARK: - Hour
struct Hour: Codable {
    var time: String?
    let tempC: Double?
    let condition: Condition?


    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String?
    let lat, lon: Double?
    let tzID: String?
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
    }
}
