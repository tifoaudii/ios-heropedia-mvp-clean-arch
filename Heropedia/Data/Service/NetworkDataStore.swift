//
//  NetworkDataStore.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 16/02/21.
//

import Foundation

final class DefaultNetworkDataStore: NetworkDataStore {
    
    static let baseImageUrl: String = "https://steamcdn-a.akamaihd.net"
    
    private let baseUrl: String = "https://api.opendota.com/api/heroStats"
    private let urlSession = URLSession.shared
    
    func fetchHero(success: @escaping ([Hero]) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        guard let url = URL(string: baseUrl) else {
            return failure(.invalidEndpoint)
        }
        
        urlSession.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                failure(.apiError)
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return failure(.invalidResponse)
            }
            
            guard let data = data else {
                return failure(.noData)
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let heroResponse = try jsonDecoder.decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    success(heroResponse)
                }
                
            } catch {
                DispatchQueue.main.async {
                    failure(.serializationError)
                }
            }
        }.resume()
    }
}
