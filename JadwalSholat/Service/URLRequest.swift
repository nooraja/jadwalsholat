//
//  URLRequest.swift
//  JadwalSholat
//
//  Created by NOOR on 19/12/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

extension URLRequest {
    func encode(with parameters: Parameters?) -> URLRequest {
        guard let parameters = parameters else {
            return self
        }
        
        var encodedURLRequest = self
        
        if let url = self.url,
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty {
            var newUrlComponents = urlComponents
            let queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            
            newUrlComponents.queryItems = queryItems
            encodedURLRequest.url = newUrlComponents.url
            return encodedURLRequest
        } else {
            return self
        }
    }
}
