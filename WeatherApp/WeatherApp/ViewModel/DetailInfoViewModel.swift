//
//  DetailInfoViewModel.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/19/20.
//

import Foundation

class DetailInfoViewModel : NSObject {
    var cityList : CityList?
    private(set) var temperatureMin:String = ""
    private(set) var temperatureMax:String = ""
    private(set) var feelsLike:String = ""
    private(set) var humidity:String = ""
    private(set) var weather:String = ""
    private(set) var cityName:String = ""
    
    override init() {
        super.init()
    }
    
    func updateProperties() {
        if let cityList = cityList {
            temperatureMin = String(format: "%.0f°C", cityList.tempMin - 273.15).description
            temperatureMax = String(format: "%.0f°C", cityList.tempMax - 273.15).description
            feelsLike = String(format: "%.0f°C", cityList.feelsLike - 273.15).description
            humidity = String(format: "%.0f%%", cityList.humidity).description
            weather = cityList.weather[0].description.capitalized
            cityName = cityList.name
        }

    }
}


