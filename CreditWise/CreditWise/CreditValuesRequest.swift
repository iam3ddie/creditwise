//
//  CreditValuesRequest.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

struct CreditValuesRequest: APIHandler {
    func makeRequest() -> URLRequest {
        var components = URLComponents(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com")
        components?.path = "/prod/mockcredit/values"
        
        return URLRequest(url: (components?.url)!)
    }
    
    func parseResponse(data: Data) throws -> CreditValues {
        return try deaultParseResponse(data: data)
    }
}
