//
//  URLSession+HTTPClient.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/22.
//

import Foundation

// MARK: - Extension HTTPClient

// URLSession型をHTTPクライアントとして使えるようにする
extension URLSession : HTTPClient {
    public func sendRequest(_ urlRequest: URLRequest,
                            completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {

        let task = self.dataTask(with: urlRequest) { data, urlResponse, error in
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                completion(Result.failure(error))
            case (let data?, let urlResponse as HTTPURLResponse, _):
                completion(Result.success((data, urlResponse)))
            default:
                fatalError("invalid response combination \(String(describing: (data, urlResponse, error))).")
            }
        }
        
        task.resume()
    }
}
