//
//  CreditValuesRequestsTests.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

import XCTest
@testable import CreditWise

class CreditValuesRequestsTests: XCTestCase {
    
    var systemUnderTest: CreditValuesRequest!
    var creditValuesStubResponse: Data!
    
    override func setUpWithError() throws {
        systemUnderTest = CreditValuesRequest()
        creditValuesStubResponse = try Data(contentsOf: URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "CreditValues", ofType: "json")!))
    }
    
    func testMakeURLRequestSuccess() {
        let urlRequest = systemUnderTest.makeRequest()
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "5lfoiyb0b3.execute-api.us-west-2.amazonaws.com")
        XCTAssertEqual(urlRequest.url?.pathComponents, ["/","prod", "mockcredit", "values"])
    }
    
    func testParseResponseSuccess() throws {
        let creditValues = try systemUnderTest.parseResponse(data: creditValuesStubResponse)
        XCTAssertEqual(creditValues.creditReportInfo.score, 514)
    }
}

