//
//  WeatherInfoViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mukul Gupta on 12/19/20.
//

import XCTest
@testable import WeatherApp

class WeatherInfoViewModelTests: XCTestCase, WeatherInfoDataReloadDelegate {

    private var weatherinfoVM: WeatherInfoViewModel!
    private var expectationWeather: XCTestExpectation!
    private var cityIdString: String = ""

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.weatherinfoVM = WeatherInfoViewModel()
        self.weatherinfoVM.reloadDelegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testgetWeatherDetailsAPI() throws {
        self.expectationWeather = self.expectation(
          description: "Get City Weather Details")
        
        //matching melbourne id with service data city id
        self.weatherinfoVM.callFuncToGetCityWeatherData(cityIds: "4163971")
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(cityIdString, "4163971")
    }
    
    func reloadDataonSucess() {
        self.cityIdString = self.weatherinfoVM.cities?.list[0].id.description ?? ""
        expectationWeather.fulfill()
    }
    
    func showAlertOnFailure(error: Error) {
        XCTFail("Some network error occured")
    }
    

}
