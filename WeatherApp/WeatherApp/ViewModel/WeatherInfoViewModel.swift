//
//  WeatherInfoViewModel.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/16/20.
//

import Foundation

protocol WeatherInfoDataReloadDelegate: class {
    func reloadDataonSucess()
    func showAlertOnFailure(error:Error)
}


class WeatherInfoViewModel : NSObject {
    private var apiService : APIService?
    var cities : Cities?
    
    private(set) var temperatureInDegress:String = ""
    private(set) var nameOfCity:String = ""
    var cityIdArray = [String]() //Array for showing the weather of selected cities id

    weak var reloadDelegate: WeatherInfoDataReloadDelegate?
    
    override init() {
        self.apiService =  APIService()
        cityIdArray.append("4163971")
        cityIdArray.append("2147714")
        cityIdArray.append("2174003")
    }
    
    func updateProperties(index:Int) {
        if let city = cities?.list[index] {
            temperatureInDegress = String(format: "%.0f°C", city.temp - 273.15).description
            nameOfCity = (city.name)
        }
    }
    
    func addCityId(cityId:String) {
        cityIdArray.append(cityId)
    }
    
    func getCitiesCount() -> Int {
        return self.cities?.list.count ?? 0
    }
    
    func callFuncToGetCityWeatherData(cityIds:String) {
        let urlString = BaseUrl.getCityDataService+cityIds+"&appid="+appId
        self.apiService?.apiToGetCityWeatherData(stringURL:urlString) { [weak self](result) in
            switch result {
            case .success(let cityWeatherData):
                self?.cities = cityWeatherData
                self?.reloadDelegate?.reloadDataonSucess()
              case .failure(let error):
                self?.reloadDelegate?.showAlertOnFailure(error: error)
              }
        }
    }
}
