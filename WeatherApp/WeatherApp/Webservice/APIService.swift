//
//  APIService.swift
//  WeatherApp
//
//  Created by Mukul Gupta on 12/16/20.
//

import Foundation
/// A value that represents either a success or a failure, including an
/// associated value in each case.
public enum Result<Success, Failure: Error> {
  /// A success, storing a `Success` value.
  case success(Success)

  /// A failure, storing a `Failure` value.
  case failure(Failure)
}


class APIService :  NSObject {
    
    func apiToGetCityWeatherData(stringURL:String,completion:@escaping (Result<Cities?, URLError>)->Void)  {
        let sourcesURL = URL(string:stringURL)!
        URLSession.shared.dataTask(with: sourcesURL) {(data, response, error) in
            if let urlError = error as? URLError {
              completion(.failure(urlError))
            }

            if let data = data {
                let jsonDecoder = JSONDecoder()
                let cityWeatherData = try! jsonDecoder.decode(Cities.self, from: data)
                print(cityWeatherData)
                completion(.success(cityWeatherData))
            }
        }.resume()
    }
    
}
