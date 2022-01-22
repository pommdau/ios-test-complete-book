//
//  GitHubAPIError.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/21.
//

import Foundation

public struct GitHubAPIError : Decodable, Error {
    
    // MARK: - Definition
    
    public struct Error : Decodable {
        public var resource: String
        public var field: String
        public var code: String
    }
    
    // MARK: - Properties
    
    public var message: String  // レスポンスのJSONに必ず含まれる
    public var errors: [Error]
}
