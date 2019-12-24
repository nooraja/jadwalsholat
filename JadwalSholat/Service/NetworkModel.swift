//
//  NetworkModel.swift
//  JadwalSholat
//
//  Created by NOOR on 19/12/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import Foundation

class NetworkModel {
    
    func fetchRemote<Model: Decodable>(url: URLRequest, completion: @escaping (Result<Model, DataResponseError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data else {
                    return completion(.failure(.network))
            }
            
            guard let decodeResponse = try? JSONDecoder().decode(Model.self, from: data) else {
                completion(.failure(.decoding))
                return
            }
            
            completion(.success(decodeResponse))
        }.resume()
    }
}
