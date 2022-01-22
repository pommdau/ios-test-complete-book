//
//  GitHubRequest.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/22.
//

import Foundation

// MARK: - Protocol GitHubRequest

public protocol GitHubRequest {
    
    associatedtype Response: Decodable  // Responseは連想型。リクエストの型からレスポンスの型を決定できるようにする。
    
    var baseURL: URL { get }
    var path: String { get }  // baesURLからの相対パス
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }  // URLQueryItem: クエリ文字列を表すための型
//    var body: Encodable? { get }  // HTTP bodyに設定するパラメータ(POSTやPUTリクエストをする場合)
    
}

// MARK: - Extenstion GitHubRequest

public extension GitHubRequest {
    
    var baseURL: URL {  // デフォルト実装
        return URL(string: "https://api.github.com")!
    }
    
    // GitHubRequestに準拠した型 -> URLRequest型へ変換するためのメソッド
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        switch method {
        case .get:
            components?.queryItems = queryItems  // クエリの追加
        default:
            fatalError("Unsupported method \(method)")
        }
        
        /*
         var urlRequest = URLRequest(url: components?.url)とかけない？
         */
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url  // URLComponents型からURL型を取得。これにより適切なエンコードを施したクエリ文字列が付与される
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    /*
     HTTPClientでURLSessionクラスを通じて受け取った、Data型とHTPPTURLResponse型の値をもとに連想型Responseの値を生成する
     戻り値のResponseは連想型で、リクエストの型に応じた適切なものになる
     */
    func response(from data: Data,
                  urlResponse: HTTPURLResponse) throws -> Response {

        let decoder = JSONDecoder()
        if (200..<300).contains(urlResponse.statusCode) {
            return try decoder.decode(Response.self, from: data)
        } else {
            throw try decoder.decode(GitHubAPIError.self, from: data)
        }
    }
}
