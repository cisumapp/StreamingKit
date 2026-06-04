//
//  NetworkManager.swift
//  APICaller
//
//  Created by Zain Wu on 2024/5/29.
//

import Foundation

enum NetworkManager {
    @discardableResult
    static func requestGet(
        url: String,
        queryItems: [String: Any]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (_ result: Result<Data, Error>) -> Void
    ) -> URLSessionTask? {
        guard let base = URL(string: url),
              var urlComponents = URLComponents(url: base, resolvingAgainstBaseURL: false)
        else {
            completion(.failure(NSError(domain: "URL is illegal.", code: 1)))
            return nil
        }
        let queryItems: [URLQueryItem]? = queryItems == nil ? nil : queryItems!.map { key, value in
            URLQueryItem(name: key, value: value as? String)
        }
        urlComponents.queryItems = queryItems
        guard let requestUrl = urlComponents.url else {
            completion(.failure(NSError(domain: "URL is illegal.", code: 1)))
            return nil
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                completion(.failure(error ?? NSError(domain: "An error occurred during URL Get request.", code: 2)))
                return
            }
            completion(.success(data))
        }
        task.resume()
        return task
    }
}
