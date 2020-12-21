//
//  DetailInfoViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mukul Gupta on 12/20/20.
//

import XCTest
@testable import WeatherApp

class DetailInfoViewModelTests: XCTestCase {

    private var detailInfoVM: DetailInfoViewModel!

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.detailInfoVM = DetailInfoViewModel()
        self.getCitiesFromLocalJSonFile()
        detailInfoVM.updateProperties()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.detailInfoVM = nil
    }
    
    func testDecodeCityName() throws {
        XCTAssertEqual(self.detailInfoVM.cityName, "Burgess Hill")
    }
    
    func testDecodeWeatherDesc() throws {
        XCTAssertEqual(self.detailInfoVM.weather, "broken clouds".capitalized)
    }

    func testDecodeHumidity() throws {
        XCTAssertEqual(self.detailInfoVM.humidity,"93%")
    }
    
    func testDecodeMaxTemp() throws {
        XCTAssertEqual(self.detailInfoVM.temperatureMax,"11°C")
    }
    
    func testDecodeMinTemp() throws {
        XCTAssertEqual(self.detailInfoVM.temperatureMin,"10°C")
    }
    
    func getCitiesFromLocalJSonFile() {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let cityWeatherData = try! jsonDecoder.decode(Cities.self, from: data)
                print(cityWeatherData)
                detailInfoVM.cityList = cityWeatherData.list[0]
            }
            catch {
                fatalError("data not found")
            }
        }
    }

}
