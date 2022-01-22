//
//  StubHTTPClient.swift
//  GitHubSearchAPIClientTests
//
//  Created by HIROKI IKEUCHI on 2022/01/22.
//

import Foundation
import GitHubSearchAPIClient

class StubHTTPClient : HTTPClient {
    // テスト用にresult情報を持てるようにする
    var result: Result<(Data, HTTPURLResponse), Error> =
        .success((
            Data(),
            HTTPURLResponse(url: URL(string: "https://example.com")!,
                            statusCode: 200,
                            httpVersion: nil,
                            headerFields: nil)!
        ))
    
    func sendRequest(_ urlRequest: URLRequest,
                     completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            completion(self.result)
        }
    }
}
