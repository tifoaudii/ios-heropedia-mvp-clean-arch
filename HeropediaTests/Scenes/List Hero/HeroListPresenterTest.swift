//
//  HeroListPresenterTest.swift
//  HeropediaTests
//
//  Created by Tifo Audi Alif Putra on 17/02/21.
//

@testable import Heropedia
import XCTest

class HeroListPresenterTest: XCTestCase {
    
    // MARK:- System under test
    
    var sut: DefaultHeroListPresenter!

    // MARK:- Test lifecycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK:- Mock
    
    class HeroListViewControllerMock: HeroListViewPresentationProtocol {
        
        // MARK:- Spy Properties
        var showHeroCalled = false
        var reloadDataCalled = false
        var showErrorCalled = false
        var showInternetConnectionProblemCalled = false
        
        func showHero() {
            showHeroCalled = true
        }
        
        func reloadData() {
            reloadDataCalled = true
        }
        
        func showError() {
            showErrorCalled = true
        }
        
        func showInternetConnectionProblemMessage() {
            showInternetConnectionProblemCalled = true
        }
    }
    
    class NetworkServiceMock: NetworkService {
        
        private let testScenario: TestScenario
        
        init(testScenario: TestScenario) {
            self.testScenario = testScenario
            super.init(
                dataStore: NetworkDataStoreMock(
                    testScenario: testScenario
                ),
                cacheRepository: NetworkCacheRepositoryMock()
            )
        }
        
        // MARK: Spy Properties
        var fetchHeroCalled = false
        var loadHeroCalled = false
        
        override func fetchHero(onSuccess: @escaping ([Hero]) -> Void, onFailure: @escaping (ErrorResponse) -> Void) {
            fetchHeroCalled = true
            
            if testScenario == .success {
                onSuccess([])
            } else {
                onFailure(.apiError)
            }
        }
        
        override func loadHero(onSuccess: @escaping ([Hero]) -> Void, onFailure: @escaping (Error) -> Void) {
            loadHeroCalled = true
            
            if testScenario == .success {
                onSuccess([])
            } else {
                onFailure(NSError())
            }
        }
    }
    
    
    // MARK:- Testcase
    
    func testPresenterShouldAskNetworkServiceToFetchHero() {
        // Given
        let networkServiceMock = NetworkServiceMock(testScenario: .success)
        sut = DefaultHeroListPresenter(service: networkServiceMock)
        
        // When
        sut.fetchHero()
        
        // Then
        XCTAssert(networkServiceMock.fetchHeroCalled)
    }
    
    func testPresenterShouldAskViewControllerToShowHeroIfRequestWasSucceed() {
        // Given
        let networkServiceMock = NetworkServiceMock(testScenario: .success)
        let viewControllerMock = HeroListViewControllerMock()
        
        sut = DefaultHeroListPresenter(service: networkServiceMock)
        sut.setViewController(viewController: viewControllerMock)
        
        // When
        sut.fetchHero()
        
        // Then
        XCTAssert(viewControllerMock.showHeroCalled)
    }
    
    func testPresenterShouldAskViewControllerToShowErrorIfRequestWasFailed() {
        // Given
        let networkServiceMock = NetworkServiceMock(testScenario: .failed)
        let viewControllerMock = HeroListViewControllerMock()
        
        sut = DefaultHeroListPresenter(service: networkServiceMock)
        sut.setViewController(viewController: viewControllerMock)
        
        // When
        sut.fetchHero()
        
        // Then
        XCTAssert(viewControllerMock.showInternetConnectionProblemCalled)
    }
    
    func testPresenterShouldAskNetworkServiceToLoadHeroFromLocalStorage() {
        // Given
        let networkServiceMock = NetworkServiceMock(testScenario: .success)
        sut = DefaultHeroListPresenter(service: networkServiceMock)
        
        // When
        sut.loadHero()
        
        // Then
        XCTAssert(networkServiceMock.loadHeroCalled)
    }
    
    func testPresenterShouldAskViewControllerToShowHeroIfLoadOperationIsSucceed() {
        // Given
        let networkServiceMock = NetworkServiceMock(testScenario: .success)
        let viewControllerMock = HeroListViewControllerMock()
        
        sut = DefaultHeroListPresenter(service: networkServiceMock)
        sut.setViewController(viewController: viewControllerMock)
        
        // When
        sut.loadHero()
        
        // Then
        XCTAssert(viewControllerMock.showHeroCalled)
    }
    
    func testPresenterShouldAskViewControllerToReloadWhenFinishFilterHero() {
        // Given
        let networkServiceMock = NetworkServiceMock(testScenario: .success)
        let viewControllerMock = HeroListViewControllerMock()
        
        sut = DefaultHeroListPresenter(service: networkServiceMock)
        sut.setViewController(viewController: viewControllerMock)
        
        // When
        sut.filterHeroWith(role: .carry)
        
        // Then
        XCTAssert(viewControllerMock.reloadDataCalled)
    }
    
}
