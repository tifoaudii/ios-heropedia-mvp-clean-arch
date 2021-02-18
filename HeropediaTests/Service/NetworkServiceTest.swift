//
//  NetworkServiceTest.swift
//  HeropediaTests
//
//  Created by Tifo Audi Alif Putra on 17/02/21.
//

@testable import Heropedia
import XCTest

enum TestScenario {
    case success
    case failed
}

class NetworkServiceTest: XCTestCase {
    
    // MARK:- System under test
    var sut: NetworkService!
    
    // MARK:- Test lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: Testcase
    
    func testNetworkServiceSuccessFetchHero() {
        // Given
        let mockDataStore = NetworkDataStoreMock(testScenario: .success)
        let mockCacheRepository = NetworkCacheRepositoryMock()
        sut = NetworkService(dataStore: mockDataStore, cacheRepository: mockCacheRepository)
        
        // Then
        sut.fetchHero { (hero: [Hero]) in
            XCTAssert(!hero.isEmpty)
        } onFailure: { (_) in }
    }
    
    func testNetworkServiceSuccessLoadHero() {
        // Given
        let mockDataStore = NetworkDataStoreMock(testScenario: .success)
        let mockCacheRepository = NetworkCacheRepositoryMock()
        sut = NetworkService(dataStore: mockDataStore, cacheRepository: mockCacheRepository)
        
        // Then
        sut.loadHero { (hero: [Hero]) in
            XCTAssert(!hero.isEmpty)
        } onFailure: { (_) in }
    }
}
