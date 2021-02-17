//
//  NetworkService.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 15/02/21.
//

import Foundation

protocol NetworkDataStore {
    func fetchHero(success: @escaping (_ hero: [Hero]) -> Void, failure: @escaping (_ error: ErrorResponse) -> Void)
}

class NetworkService {
    
    private let dataStore: NetworkDataStore
    private let cacheRepository: NetworkCacheRepository
    
    init(dataStore: NetworkDataStore, cacheRepository: NetworkCacheRepository) {
        self.dataStore = dataStore
        self.cacheRepository = cacheRepository
    }
    
    func fetchHero(onSuccess: @escaping (_ heroes: [Hero]) -> Void, onFailure: @escaping (_ error: ErrorResponse) -> Void) {
        dataStore.fetchHero { [weak self] (hero: [Hero]) in
            self?.cacheRepository.save(data: hero)
            DispatchQueue.main.async {
                onSuccess(hero)
            }
        } failure: { (error: ErrorResponse) in
            DispatchQueue.main.async {
                onFailure(error)
            }
        }
    }
    
    func loadHero(onSuccess: @escaping (_ heroes: [Hero]) -> Void, onFailure: @escaping (Error) -> Void) {
        cacheRepository.load { (hero: [Hero]) in
            DispatchQueue.main.async {
                onSuccess(hero)
            }
        } onFailure: { (error: Error) in
            DispatchQueue.main.async {
                onFailure(error)
            }
        }

    }
}

public enum ErrorResponse: String {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var description: String {
        switch self {
        case .apiError: return "Ooops, there is something problem with the api"
        case .invalidEndpoint: return "Ooops, there is something problem with the endpoint"
        case .invalidResponse: return "Ooops, there is something problem with the response"
        case .noData: return "Ooops, there is something problem with the data"
        case .serializationError: return "Ooops, there is something problem with the serialization process"
        }
    }
}

