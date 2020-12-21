//
//  AddLocationViewModelTests.swift
//  WeatherAppTests
//
//  Created by Mukul Gupta on 12/21/20.
//

import XCTest
@testable import WeatherApp

class AddLocationViewModelTests: XCTestCase {

    private var addLocationVM: AddLocationViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.addLocationVM = AddLocationViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.addLocationVM = nil
    }
    
    func testIfFileContainsValidJSON() throws {
        self.addLocationVM.getCitiesFromLocalJSonFile()
        XCTAssertEqual(self.addLocationVM.cities?.cnt,10)
    }
    
    func testSearchCityLocationName() throws {
        self.addLocationVM.getCitiesFromLocalJSonFile()
        self.addLocationVM.filterListOfCities(locationName: "Burgess Hill")
        self.addLocationVM.updateRecords(index: 0)
        XCTAssertEqual(self.addLocationVM.nameOfCity,"Burgess Hill")
    }

}
