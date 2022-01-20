//
//  ViewController.swift
//  GitHubSearchAPIClient
//
//  Created by HIROKI IKEUCHI on 2022/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Lifecycles
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.text = "hello"
    }
    
    // MARK: - Actions

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        print("DEBUG: \(searchTextField.text ?? "(nil)")")
        
        // Entry Point
        
        print("Enter your query here> ", terminator: "")
        
        guard let keyword = searchTextField.text else {
            return
        }
        
        // APIクライアントの作成
        let client = GitHubClient(httpClient: URLSession.shared)
        
        // Requestの発行
        let request = GitHubAPIRequest.SearchRepositories(keyword: keyword)
        
        // リクエストの送信
        client.send(request: request) { result in
            switch result {
            case .success(let response):
                for item in response.items {
                    print(item.owner.login + "/" + item.name)
                }
                return
            case .failure(let error):
                print(error)
                return
            }
        }
        
        // タイムアウト時間
        let timeoutInterval: TimeInterval = 5
        
        // タイムアウトまでメインスレッドを停止
        Thread.sleep(forTimeInterval: timeoutInterval)
        
        // タイムアウト後の処理
        print("Connection timeout")
        return
    }
    
    // MARK: - Helpers
    
}

