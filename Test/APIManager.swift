//
//  APIManager.swift
//  Test
//
//  Created by 홍정민 on 11/7/24.
//

import UIKit

enum APIError: Error {
    case fetchError
    case badID
    case badImage
}

protocol APIType: AnyObject {
    func callNetworkByGCD(_ url: URL, completion: @escaping (UIImage?, APIError?) -> Void)
    func callNetworkByConcurrency(_ url: URL) async throws -> UIImage
}

final class APIManager: APIType {
    static let shared = APIManager()
    private init() { }
    
    func callNetworkByGCD(_ url: URL, completion: @escaping (UIImage?, APIError?) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.runDataTask(request: request) { data, response, error in
            if let _ = error {
                completion(nil, .fetchError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .badID)
                return
            }
            
            guard let data = data else {
                completion(nil, .badImage)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(nil, .badImage)
                return
            }
            
            completion(image, nil)
            
        }
    }
    
    func callNetworkByConcurrency(_ url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        print(#function, Thread.isMainThread)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.badID }
        guard let image = UIImage(data: data) else { throw APIError.badImage }
        return image
    }
    
}

