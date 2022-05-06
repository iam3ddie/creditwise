//
//  CreditValuesRepository.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

protocol CreditValuesRepository {
    func fetchCreditValues(completionHandler: @escaping (CreditValues?, NetworkClientError?) -> Void)
}

class CreditValuesRepositoryImplementation: CreditValuesRepository {
    var networkClient: NetworkClientProtocol?
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCreditValues(completionHandler: @escaping (CreditValues?, NetworkClientError?) -> Void) {
        let request = CreditValuesRequest()
        networkClient?.executeRequest(request: request, completionHandler: { creditValues, error in
            completionHandler(creditValues, error)
        })
    }
}
