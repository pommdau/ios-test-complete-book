//
//  SearchResponse.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/21.
//
// リポジトリ以外の検索結果にも使えるように<Item : Decodable>を使う

import Foundation

public struct SearchResponse<Item : Decodable> : Decodable {
    public var totalCount: Int
    public var items: [Item]
    
    public enum CodingKeys : String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
