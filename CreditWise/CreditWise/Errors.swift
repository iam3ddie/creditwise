//
//  Errors.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

enum NetworkClientError: Error {
    case notConnectedToTheInternet
    case parseError
    case general(Error?)
}
