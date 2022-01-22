//
//  SearchResponseTests.swift
//  GitHubSearchAPIClientTests
//
//  Created by HIROKI IKEUCHI on 2022/01/21.
//

import Foundation
import XCTest
import GitHubSearchAPIClient

class SearchResponseTests: XCTestCase {

    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = SearchResponse.exampleJSON.data(using: .utf8)!
        let response = try jsonDecoder.decode(SearchResponse<Repository>.self, from: data)
        
        XCTAssertEqual(response.totalCount, 141722)
        XCTAssertEqual(response.items.count, 3)
        
        let firstRepository = response.items.first
        XCTAssertEqual(firstRepository?.name, "swift")
        XCTAssertEqual(firstRepository?.fullName, "apple/swift")
    }
    
}
