//
//  UserTests.swift
//  GitHubSearchAPIClientTests
//
//  Created by HIROKI IKEUCHI on 2022/01/21.
//

import Foundation
import XCTest
import GitHubSearchAPIClient

class UserTests: XCTestCase {
    
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = User.exampleJSON.data(using: .utf8)!
        let user = try jsonDecoder.decode(User.self, from: data)
        
        XCTAssertEqual(user.id, 10639145)
        XCTAssertEqual(user.login, "apple")
    }
    
}
