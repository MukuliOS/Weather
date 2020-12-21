//
//  AddLocationViewModel.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/20/20.
//

import Foundation

class AddLocationViewModel : NSObject {
    
    private(set) var cities : Cities?
    private(set) var nameOfCity:String = ""
    private(set) var cityId:String = ""
    private(set) var filteredCities: [CityList] = []

    override init() {
        super.init()
    }
    
    func getCitiesFromLocalJSonFile() {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let cityWeatherData = try! jsonDecoder.decode(Cities.self, from: data)
                print(cityWeatherData)
                cities = cityWeatherData
            }
            catch {
                fatalError("data not found")
            }
        }
    }
    
    func getFilteredCitiesCount() -> Int {
        return filteredCities.count
    }
    
    func filterListOfCities(locationName:String) {
        let filteredArray = cities?.list.filter({ (value) -> Bool in
            let range = value.name.range(of: locationName, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)
            return range != nil
        })
        
        if let filter = filteredArray {
            filteredCities = filter
        }
    }
    
    func updateRecords(index:Int) {
        let list = filteredCities[index]
            self.nameOfCity = list.name
            self.cityId = list.id.description
    }

    
}
