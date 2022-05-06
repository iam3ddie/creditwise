//
//  RequestHandler.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

protocol RequestHandler {
    func makeRequest() -> URLRequest
}
