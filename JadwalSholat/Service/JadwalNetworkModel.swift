//
//  JadwalNetworkModel.swift
//  JadwalSholat
//
//  Created by NOOR on 19/12/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data"
        case .decoding:
            return "An error occurred while decoding data"
        }
    }
}

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
    
}

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}

final class JadwalNetworkModel: NetworkModel {
    
    override init() {
        
    }
    
    func retreiveJadwal(_ request: JadwalEndpoint,_ completion: @escaping (Result<Jadwal, DataResponseError>) -> Void) {
        
        let urlRequest = URLRequest(url: request.baseUrl.appendingPathComponent(request.path))
        
        let encodeUrlRequest = urlRequest.encode(with: request.parameter)
        
        fetchRemote(url: encodeUrlRequest, completion: completion)
    }
}
