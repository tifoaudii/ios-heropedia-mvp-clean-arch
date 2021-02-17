//
//  NetworkLocalStorage.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 16/02/21.
//

import Foundation

final class NetworkLocalStorage {
    
    private let userDefault: UserDefaults?
    private let suiteName: String?
    
    init(suiteName: String?) {
        
        self.suiteName = suiteName
        
        if let name = suiteName {
            userDefault = UserDefaults(suiteName: name)
        } else {
            userDefault = UserDefaults.standard
        }
    }
    
    static func shared(suiteName: String? = nil) -> NetworkLocalStorage {
        return NetworkLocalStorage(suiteName: suiteName)
    }
    
    func save<TargetType: Codable>(
        key: String,
        data: [TargetType],
        onSuccess: (([TargetType]) -> Void)? = nil,
        onFailure: ((Error) -> Void)? = nil
    ) {
        
        do {
            let encodedData = try encode(from: data)
            userDefault?.set(encodedData, forKey: key)
            
            onSuccess?(data)
        } catch let error {
            onFailure?(error)
        }
        
    }
    
    
    func get<TargetType: Codable>(key: String, onSuccess: (([TargetType]) -> Void), onFailure: ((Error) -> Void)? = nil) {
        do {
            let data: [TargetType] = try decode(key: key)
            onSuccess(data)
        } catch let error {
            onFailure?(error)
        }
    }
    
    
    private func encode<TargetType: Codable>(from data: TargetType) throws -> String {
        let encoder = JSONEncoder()
        
        do {
            
            let encodedData = try encoder.encode(data)
            let dataStr = String(decoding: encodedData, as: UTF8.self)
            
            return dataStr
        } catch let exception {
            throw exception
        }
    }
    
    private func decode<TargetType: Decodable>(key: String) throws -> TargetType {
        
        let decoder = JSONDecoder()
        
        do {
            
            guard let dataStr = userDefault?.string(forKey: key),
                let data = dataStr.data(using: .utf8) else {
                    throw NSError()
            }
            
            let decodedData = try decoder.decode(TargetType.self, from: data)
            
            return decodedData
        } catch let exception {
            throw exception
        }
    }
    
}
