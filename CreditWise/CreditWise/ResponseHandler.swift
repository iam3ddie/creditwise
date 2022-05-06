//
//  ResponseHandler.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data) throws -> ResponseDataType
}

extension ResponseHandler {
    func deaultParseResponse<T: Codable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
