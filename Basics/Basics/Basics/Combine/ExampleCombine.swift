//
//  ExampleCombine.swift
//  Basics
//
//  Created by Roman Golub on 11.12.2024.
//

import Foundation
import SwiftUI
import Combine

// (event1) -> () -> () -> () -> () -> Time ->
// () -> (event2) -> () -> ()
// --- Megre ---
// (event1) -> (event2) -> () -> ()

// https://jsonplaceholder.typicode.com/posts

/*
 {
     id: 1,
     title: 'foo',
     body: 'bar',
     userId: 1,
   }
 */

/*
 200...299:
400: self = .badRequest(message)
401: self = .unauthorized(message)
402: self = .paymentRequired(message)
403: self = .forbidden(message)
         case 404:
             self = .notFound(message)
         case 405:
             self = .methodNotAllowed(message)
         case 406:
             self = .notAcceptable(message)
         case 408:
             self = .requestTimeout(message)
         case 409:
             self = .conflict(message)
         case 413:
             self = .payloadTooLarge(message)
         case 415:
             self = .unsupportedMediaType(message)
         case 429:
             self = .tooManyRequests(message)
         case 500:
             self = .internalServerError(message)
         case 502:
             self = .badGateway(message)
         case 503:
             self = .serviceUnavailable(message)
         case 504:
 */

struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct ApiClient {
    enum ApiError: Error {
        case badUrl
        case badRequest
        case paymentRequired
        case forbidden
        case notFound
        case internalServerError
        case serviceUnavailable
        case decodeError
        case unknown
        
        static func map(_ error: Error) -> Self {
            guard let apiError = error as? ApiError else {
                switch error {
                case _ as URLError: return ApiError.badUrl
                case _ as DecodingError: return ApiError.decodeError
                default: return ApiError.unknown
                }
            }
            return apiError
        }
    }
    
    enum StatusCode: Int {
        case ok = 200
        case badRequest = 400
        case paymentRequired = 402
        case forbidden = 403
        case notFound = 404
        case internalServerError = 500
        case serviceUnavailable = 503
    }
    
    init() {
        
    }
    
    func requestDetail(_ id: Int) -> AnyPublisher<Post, ApiError> {
        Fail(error: ApiError.badUrl)
            .eraseToAnyPublisher()
    }
    
    func request() -> AnyPublisher<[Post], ApiError> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap(parceResponce)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .mapError(ApiError.map)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func parceResponce(_ data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.unknown
        }
        
        switch StatusCode(rawValue: httpResponse.statusCode) {
        case .ok, .none: return data
        case .badRequest: throw ApiError.badRequest
        case .forbidden: throw ApiError.forbidden
        case .internalServerError: throw ApiError.internalServerError
        case .notFound: throw ApiError.notFound
        case .paymentRequired: throw ApiError.paymentRequired
        case .serviceUnavailable: throw ApiError.serviceUnavailable
        }
        
    }
}

class Receiver {
    let apiClient = ApiClient()
    var posts = [Post]()
    var cancellable = Set<AnyCancellable>()
    var isLoading = false
    var error: ApiClient.ApiError?
    var isAlertShown = false
    
    init() {
        
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    func requestPosts() {
        isLoading = true
        
        apiClient.request()
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let failure):
                    self.error = failure
                    self.isAlertShown = true
                }
            } receiveValue: { posts in
                self.posts = posts
            }
            .store(in: &cancellable)
        
 //MARK: - merge several publishers
        apiClient
            .request()
            .flatMap(performDetailRequests)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { posts in
                self.posts = posts
            }
            .store(in: &cancellable)
    }
    
    
    private func performDetailRequests(_ posts: [Post]) -> AnyPublisher<[Post], ApiClient.ApiError> {
        let result = posts
            .map(\.id)
            .map(self.apiClient.requestDetail)
        return Publishers
            .MergeMany(result)
            .collect()
            .eraseToAnyPublisher()
    }
}
