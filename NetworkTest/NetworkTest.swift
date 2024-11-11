//
//  NetworkTest.swift
//  NetworkTest
//
//  Created by 홍정민 on 11/11/24.
//

import XCTest
@testable import Test

final class NetworkTest: XCTestCase {
    
    var sut: APIType!
    
    override func setUpWithError() throws {
        sut = APIManager.shared
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testAPIManager_Validation_GCD_ReturnSuccess() async throws {
        let expectation = XCTestExpectation(description: "mock network completion")
        sut.callNetworkByGCD(NasaViewController.Nasa.photo) { image, error in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testAPIManager_Validation_Concurrency_ReturnSuccess() async throws {
        let result = try await sut.callNetworkByConcurrency(NasaViewController.Nasa.photo)
        XCTAssertNotNil(result)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
