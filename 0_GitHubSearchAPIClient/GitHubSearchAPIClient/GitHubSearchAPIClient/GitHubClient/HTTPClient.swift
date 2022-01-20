//
//  HTTPClient.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/22.
//

import Foundation

// HTTPクライアントの最小限の機能をプロトコルで定義する
public protocol HTTPClient {
    func sendRequest(_ urlRequest: URLRequest,
                     completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}
