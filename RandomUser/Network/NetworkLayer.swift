//
//  NetworkLayer.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum NetworkError: Error {
    case badUrl
    case noResponseData
    case decodingError
    case unknown
}

typealias CompletionHandler<T: Decodable> = (Result<T>) -> Void

protocol NetworkLayer {
    func sendRequest<T: Decodable>(with url: URL, completion: @escaping CompletionHandler<[T]>)
}

final class NetworkService: NetworkLayer {
    
    private let configuration: Configuration
    
    private static var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func sendRequest<T: Decodable>(with url: URL, completion: @escaping CompletionHandler<[T]>) {
        AF.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
            
                switch response.result {
                case .success:
                    guard let data = response.value else {
                        completion(.failure(NetworkError.noResponseData))
                        return
                    }
                    do {
                        let apiResponse = try NetworkService.jsonDecoder.decode(ApiResponse<T>.self, from: data)
                        completion(.success(apiResponse.results))
                    } catch {
                        completion(.failure(NetworkError.decodingError))
                    }
                case let .failure(error):
                    completion(.failure(error))
            }
        }
        
    }
}
