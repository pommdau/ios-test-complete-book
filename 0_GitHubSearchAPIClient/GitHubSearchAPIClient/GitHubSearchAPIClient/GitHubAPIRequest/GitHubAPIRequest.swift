//
//  GitHubAPIRequest.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/22.
//

import Foundation

// GitHubAPIのようにグルーピングすることで、GitHubAPI.SearchRepositoriesのようにアクセスできる
// アプリケーションの内部で複数のサービスが提供するAPIを使用する際に効果的
public final class GitHubAPIRequest {
    
    // MARK: - SearchRepositories
    
    public struct SearchRepositories : GitHubRequest {
        
        // MARK: - Properties
                
        public let keyword: String
        
        // GitHubRewuestが要求する連想型
        public typealias Response = SearchResponse<Repository>
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/search/repositories"
        }
        
        public var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
        
    }
    
    // MARK: - SearchUsers
    
    public struct SearchUsers : GitHubRequest {
        public let keyword: String
        
        // GitHubRewuestが要求する連想型
        public typealias Response = SearchResponse<User>
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/search/users"
        }
        
        public var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
        
        public var body: Encodable?
    }
}

