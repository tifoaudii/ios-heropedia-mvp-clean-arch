//
//  NetworkCacheRepository.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 16/02/21.
//

import Foundation

protocol NetworkCacheRepository {
    func save(data: [Hero])
    func load(onSuccess: @escaping ([Hero]) -> Void, onFailure: @escaping (Error) -> Void)
}

final class DefaultNetworkCacheRepository: NetworkCacheRepository {
    
    private let localStorage: NetworkLocalStorage = NetworkLocalStorage.shared(suiteName: "DOTA_HEROES_SUITE")
    private let key: String = "DOTA_HEROES_KEY_IDENTIFIER"
    
    func save(data: [Hero]) {
        localStorage.save(key: key, data: data)
    }
    
    func load(onSuccess: @escaping ([Hero]) -> Void, onFailure: @escaping (Error) -> Void) {
        localStorage.get(key: key, onSuccess: onSuccess, onFailure: onFailure)
    }
}
