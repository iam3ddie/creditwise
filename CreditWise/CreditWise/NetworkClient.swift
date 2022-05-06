//
//  NetworkClient.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

typealias APIHandler = RequestHandler & ResponseHandler

protocol NetworkSessionProtocol {
    func executeRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSessionProtocol {
    
    func executeRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}

protocol NetworkClientProtocol {
    func executeRequest<T: APIHandler>(request: T, completionHandler: @escaping (T.ResponseDataType?, NetworkClientError?) -> Void)
}

class NetworkClient: NetworkClientProtocol {
    
    var networkSession: NetworkSessionProtocol

    init(networkSession: NetworkSessionProtocol = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    func executeRequest<T: APIHandler>(request: T, completionHandler: @escaping (T.ResponseDataType?, NetworkClientError?) -> Void) {
        let urlRequest = request.makeRequest()
        
        networkSession.executeRequest(request: urlRequest) { data, response, error in
            if let error = error {
                if((error as NSError).code == NSURLErrorNotConnectedToInternet ||
                   (error as NSError).code == NSURLErrorNetworkConnectionLost) {
                    return completionHandler(nil, NetworkClientError.notConnectedToTheInternet)
                } else {
                    return completionHandler(nil, NetworkClientError.general(error))
                }
            }
            
            guard let data = data else {
                return completionHandler(nil, NetworkClientError.general(error))
            }
            
            do {
                let parsedReponse = try request.parseResponse(data: data)
                completionHandler(parsedReponse, nil)
            } catch {
                completionHandler(nil, NetworkClientError.parseError)
            }
        }
    }
}
