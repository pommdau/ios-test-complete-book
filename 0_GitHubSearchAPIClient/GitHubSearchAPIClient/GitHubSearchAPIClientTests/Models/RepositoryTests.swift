//
//  RepositoryTests.swift
//  GitHubSearchAPIClientTests
//
//  Created by HIROKI IKEUCHI on 2022/01/21.
//

import Foundation
import XCTest
import GitHubSearchAPIClient

class RepositoryTests: XCTestCase {
    
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = Repository.exampleJSON.data(using: .utf8)!
        let repository = try jsonDecoder.decode(Repository.self, from: data)
        
        XCTAssertEqual(repository.id, 44838949)
        XCTAssertEqual(repository.name, "swift")
        XCTAssertEqual(repository.fullName, "apple/swift")
        XCTAssertEqual(repository.owner.id, 10639145)
    }
    
}
