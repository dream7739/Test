//
//  URLSession+.swift
//  Test
//
//  Created by 홍정민 on 11/7/24.
//

import Foundation

extension URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func runDataTask(request: URLRequest, completion: @escaping CompletionHandler) {
        dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }
        .resume()
    }
}
