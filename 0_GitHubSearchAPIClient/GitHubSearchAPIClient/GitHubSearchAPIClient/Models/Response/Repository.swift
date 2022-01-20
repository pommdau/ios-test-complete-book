//
//  Repository.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/21.
//

import Foundation

public struct Repository: Decodable {
    public var id       : Int
    public var name     : String
    public var fullName : String
    public var owner    : User
    
    public enum CodingKeys : String, CodingKey {
        case id
        case name
        case fullName = "full_name"  // "full_name"がJSONに使われている
        case owner
    }
}

