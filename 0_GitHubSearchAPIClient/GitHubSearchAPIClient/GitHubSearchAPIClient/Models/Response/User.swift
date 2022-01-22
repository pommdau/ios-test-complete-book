//
//  User.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/21.
//

import Foundation

public struct User: Decodable {
    public var id: Int
    public var login: String
}
