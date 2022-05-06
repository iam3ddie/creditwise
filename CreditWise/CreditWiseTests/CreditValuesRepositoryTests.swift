//
//  CreditValuesRepositoryTests.swift
//  CreditWiseTests
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

import XCTest
@testable import CreditWise

class CreditValuesRepositoryTests: XCTestCase {
    
    var systemUnderTest: CreditValuesRepository!
    var creditValuesStubData: Data!
    
    override func setUpWithError() throws {
        creditValuesStubData = try Data(contentsOf: URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "CreditValues", ofType: "json")!))
    }
    
    func testFetchCreditValuesSuccess() {
        class MockNetworkClient: NetworkClientProtocol {
            var creditValuesStubData: Data
            
            init(creditValuesStubData: Data) {
                self.creditValuesStubData = creditValuesStubData
            }
            
            func executeRequest<T: APIHandler>(request: T, completionHandler: @escaping (T.ResponseDataType?, NetworkClientError?) -> Void) {
                let parsedResponse = try? request.parseResponse(data: creditValuesStubData)
                completionHandler(parsedResponse, nil)
            }
        }
        
        let client = MockNetworkClient(creditValuesStubData: creditValuesStubData)
        systemUnderTest = CreditValuesRepositoryImplementation(networkClient: client)
        
        let expectation = XCTestExpectation(description: "response")
        
        systemUnderTest.fetchCreditValues { creditValues, error in
            XCTAssertEqual(creditValues?.creditReportInfo.score, 514)
            expectation.fulfill()
        }
    }
    
    func testFetchCreditValuesFailure() {
        class MockNetworkClient: NetworkClientProtocol {
            var stubError: NetworkClientError
            
            init(stubError: NetworkClientError) {
                self.stubError = stubError
            }
            
            func executeRequest<T: APIHandler>(request: T, completionHandler: @escaping (T.ResponseDataType?, NetworkClientError?) -> Void) {
                completionHandler(nil, stubError)
            }
        }
        
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: ""])
        let stubNetworkError = NetworkClientError.general(error)
        let client = MockNetworkClient(stubError: stubNetworkError)
        systemUnderTest = CreditValuesRepositoryImplementation(networkClient: client)
        
        let expectation = XCTestExpectation(description: "failure")
        
        systemUnderTest.fetchCreditValues { creditValues, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
    }
}
