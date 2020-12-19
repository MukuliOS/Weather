//
//  WeatherInformationVC.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/16/20.
//

import Foundation

struct Cities:Decodable {
    var cnt:Int
    var list:[CityList]
}

struct CityWeather:Decodable {
    var description:String
    
    enum weatherKeys: String, CodingKey {
        case description
    }
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: weatherKeys.self)
        self.description = try rootContainer.decode(String.self, forKey:.description)
    }
}

struct CityList: Decodable {
    var name: String
    var id: Int
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var humidity:Double
    var weather:[CityWeather]

    enum CodingKeys: String, CodingKey {
        case main = "main"
        case name
        case weather
        case id
        // for nested Dictionary
        enum mainTemperatureKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
        }
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try rootContainer.decode(Int.self, forKey:.id)
        self.name = try rootContainer.decode(String.self, forKey:.name)
        self.weather = try rootContainer.decode([CityWeather].self, forKey:.weather)
        let userDataContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.mainTemperatureKeys.self, forKey: .main)
        
        self.temp = try userDataContainer.decode(Double.self, forKey: .temp)
        self.feelsLike = try userDataContainer.decode(Double.self, forKey: .feelsLike)
        self.tempMin = try userDataContainer.decode(Double.self, forKey: .tempMin)
        self.tempMax = try userDataContainer.decode(Double.self, forKey: .tempMax)
        self.humidity = try userDataContainer.decode(Double.self, forKey: .humidity)
    }
}


