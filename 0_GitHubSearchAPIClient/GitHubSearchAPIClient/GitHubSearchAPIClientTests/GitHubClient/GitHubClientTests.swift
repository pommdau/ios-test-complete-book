//
//  GitHubClientTests.swift
//  GitHubSearchAPIClientTests
//
//  Created by HIROKI IKEUCHI on 2022/01/22.
//

import Foundation
import XCTest
@testable import GitHubSearchAPIClient

class GitHubClientTests : XCTestCase {
    
    // MARK: - Properties
        
    var httpClient: StubHTTPClient!
    var gitHubClient: GitHubClient!
    
    // MARK: - Lifecycles
    
    override func setUp() {
        super.setUp()
        httpClient = StubHTTPClient()
        gitHubClient = GitHubClient(httpClient: httpClient)
    }
    
    // MARK: - Helpers
    
    // 通信の成功時の結果を指定しやすくするためのファクトリメソッド
    private func makeHTTPClientResult(statusCode: Int,
                                      json: String) -> Result<(Data, HTTPURLResponse), Error> {
        return .success((
            json.data(using: .utf8)!,
            HTTPURLResponse(
                url: URL(string: "https://api.github.com/search/repositories")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil)!
        ))
    }
    
    // MARK: - Test Cennection
    
    // MARK: Success Tests
    
    /// APIの呼び出しが正常に完了した場合
    func testSuccess() {
        // StubHTTPClientのresult変数に予想される結果を格納
        httpClient.result = makeHTTPClientResult(
            statusCode: 200,
            json: GitHubAPIRequest.SearchRepositories.Response.exampleJSON)

        let request = GitHubAPIRequest.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .success(let response):
                let repository = response.items.first
                XCTAssertEqual(repository?.fullName, "apple/swift")
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
    
    // MARK: GitHubClientError Tests
    
    func testFailureByConnectionError() {
        httpClient.result = .failure(URLError(.cannotConnectToHost))
        
        let request = GitHubAPIRequest.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .failure(.connectionError):
                break
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
    
    func testFailureByResponseParseError() {
        httpClient.result = makeHTTPClientResult(
            statusCode: 200,
            json: "{}")
        
        let request = GitHubAPIRequest.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .failure(.responseParseError):
                break
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
    
    func testFailureByAPIError() {
        httpClient.result = makeHTTPClientResult(
            statusCode: 400,
            json: GitHubAPIError.exampleJSON)

        let request = GitHubAPIRequest.SearchRepositories(keyword: "")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .failure(.apiError(let error)):
                XCTAssertEqual(error.message, "Validation Failed")
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
}

