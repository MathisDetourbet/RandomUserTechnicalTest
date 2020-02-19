//
//  ApiDataAccess.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation

protocol DataAccess {
    func fetchBunchRandomUser(with page: Int, count: Int, completion: @escaping CompletionHandler<[RandomUser]>)
}

struct ApiDataAccess: DataAccess {
    let apiConfiguration: Configuration
    let networkService: NetworkLayer
    
    init(apiConfiguration: Configuration, networkService: NetworkLayer) {
        self.apiConfiguration = apiConfiguration
        self.networkService = networkService
    }
    
    func fetchBunchRandomUser(with page: Int, count: Int, completion: @escaping CompletionHandler<[RandomUser]>) {
        var urlComponents = URLComponents(string: apiConfiguration.baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "results", value: "\(count)")
        ]
        guard let url = urlComponents?.url else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        
        networkService.sendRequest(with: url) { (result: Result<[RandomUser]>) in
            completion(result)
        }
    }
}

