//
//  NetworkClientTests.swift
//  CreditWiseTests
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

import XCTest
@testable import CreditWise

class NetworkClientTests: XCTestCase {
    
    var systemUnderTest: NetworkClientProtocol!
    var stubData: Data!

    override func setUpWithError() throws {
        stubData = try Data(contentsOf: URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "CreditValues", ofType: "json")!))
    }
    
    func testExecuteRequestWithSuccess() {
        class MockNetworkSession: NetworkSessionProtocol {
            var stubData: Data!
            
            init(stubData: Data) {
                self.stubData = stubData
            }
            
            func executeRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
                completion(stubData, nil, nil)
            }
        }
        
        let session = MockNetworkSession(stubData: stubData)
        systemUnderTest = NetworkClient(networkSession: session)
        
        let expectation = XCTestExpectation(description: "response")
        
        let request = CreditValuesRequest()
        systemUnderTest.executeRequest(request: request) { (creditValues, error) in
            XCTAssertNotNil(creditValues)
            expectation.fulfill()
        }
    }
    
    func testExecuteRequestWithFailure() {
        class MockNetworkSession: NetworkSessionProtocol {
            var stubError: Error
            
            init(stubError: Error) {
                self.stubError = stubError
            }
            
            func executeRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
                completion(nil, nil, NetworkClientError.general(stubError))
            }
        }
        
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: ""])
        let session = MockNetworkSession(stubError: error)
        systemUnderTest = NetworkClient(networkSession: session)
        
        let expectation = XCTestExpectation(description: "failure")
        
        let request = CreditValuesRequest()
        systemUnderTest.executeRequest(request: request) { (creditValues, error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
    }
}
