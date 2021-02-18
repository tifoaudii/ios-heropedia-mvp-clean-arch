//
//  HeroListViewControllerTest.swift
//  HeropediaTests
//
//  Created by Tifo Audi Alif Putra on 17/02/21.
//

@testable import Heropedia
import XCTest

class HeroListViewControllerTest: XCTestCase {
    
    // MARK:- Helper
    static var heroes: [Hero] = [
        Hero(id: 1, name: "Anti_Mage", localizedName: "Anti Mage ", primaryAttr: .agi, attackType: .melee, roles: [.carry, .disabler], img: "", icon: "", baseHealth: 300, baseHealthRegen: 300, baseMana: 300, baseManaRegen: 456, baseArmor: 123, baseMr: 323, baseAttackMin: 213, baseAttackMax: 424, baseStr: 433, baseAgi: 1221, baseInt: 43, strGain: 344, agiGain: 213, intGain: 343, attackRange: 35, projectileSpeed: 787, attackRate: 343, moveSpeed: 534, turnRate: 2437, cmEnabled: false, legs: 989, heroID: 4342, turboPicks: 78, turboWINS: 983, proBan: 983, proWin: 478, proPick: 23, the1_Pick: 4239, the1_Win: 892, the2_Pick: 3, the2_Win: 984, the3_Pick: 3829, the3_Win: 48, the4_Pick: 238, the4_Win: 489, the5_Pick: 89, the5_Win: 89, the6_Pick: 89, the6_Win: 89, the7_Pick: 89, the7_Win: 89, the8_Pick: 89, the8_Win: 89, nullPick: 89, nullWin: 89),
        Hero(id: 2, name: "Anti_Archet", localizedName: "Anti Archer ", primaryAttr: .int, attackType: .ranged, roles: [.durable, .escape], img: "", icon: "", baseHealth: 300, baseHealthRegen: 300, baseMana: 300, baseManaRegen: 456, baseArmor: 123, baseMr: 323, baseAttackMin: 213, baseAttackMax: 424, baseStr: 433, baseAgi: 1221, baseInt: 43, strGain: 344, agiGain: 213, intGain: 343, attackRange: 35, projectileSpeed: 787, attackRate: 343, moveSpeed: 534, turnRate: 2437, cmEnabled: false, legs: 989, heroID: 4342, turboPicks: 78, turboWINS: 983, proBan: 983, proWin: 478, proPick: 23, the1_Pick: 4239, the1_Win: 892, the2_Pick: 3, the2_Win: 984, the3_Pick: 3829, the3_Win: 48, the4_Pick: 238, the4_Win: 489, the5_Pick: 89, the5_Win: 89, the6_Pick: 89, the6_Win: 89, the7_Pick: 89, the7_Win: 89, the8_Pick: 89, the8_Win: 89, nullPick: 89, nullWin: 89),
        Hero(id: 2, name: "Baygon", localizedName: "Baygon", primaryAttr: .str, attackType: .ranged, roles: [.jungler, .nuker], img: "", icon: "", baseHealth: 300, baseHealthRegen: 300, baseMana: 300, baseManaRegen: 456, baseArmor: 123, baseMr: 323, baseAttackMin: 213, baseAttackMax: 424, baseStr: 433, baseAgi: 1221, baseInt: 43, strGain: 344, agiGain: 213, intGain: 343, attackRange: 35, projectileSpeed: 787, attackRate: 343, moveSpeed: 534, turnRate: 2437, cmEnabled: false, legs: 989, heroID: 4342, turboPicks: 78, turboWINS: 983, proBan: 983, proWin: 478, proPick: 23, the1_Pick: 4239, the1_Win: 892, the2_Pick: 3, the2_Win: 984, the3_Pick: 3829, the3_Win: 48, the4_Pick: 238, the4_Win: 489, the5_Pick: 89, the5_Win: 89, the6_Pick: 89, the6_Win: 89, the7_Pick: 89, the7_Win: 89, the8_Pick: 89, the8_Win: 89, nullPick: 89, nullWin: 89)
    ]
    
    // MARK:- System under test
    var sut: HeroListViewController!
    var window: UIWindow!

    // MARK:- Test lifecycles
    override func setUpWithError() throws {
        window = UIWindow()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        window = nil
        try super.tearDownWithError()
    }
    
    // MARK:- Private
    
    private func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK:- Mock
    
    class HeroListPresenterMock: HeroListPresenter {
        
        // MARK:- Private properties
        
        private var _allHeroes: [Hero] = []
        private var _filteredHeroes: [Hero] = []
        private var _selectedRole: Role = .all
        
        // MARK:- Spy properties
        
        var startNetworkMonitoringCalled = false
        var stopNetworkMonitoringCalled = false
        var loadHeroCalled = false
        var fetchHeroCalled = false
        var filterHeroCalled = false
        var shouldShowHeroDetail = false
        
        var allHeroes: [Hero] {
            return _allHeroes
        }
        
        var filteredHeroes: [Hero] {
            return _filteredHeroes
        }
        
        var roles: [Role] {
            return Role.allCases
        }
        
        var selectedRole: Role {
            return _selectedRole
        }
        
        func startNetworkMonitoring() {
            startNetworkMonitoringCalled = true
        }
        
        func stopNetworkMonitoring() {
            stopNetworkMonitoringCalled = true
        }
        
        func loadHero() {
            _allHeroes = heroes
            _filteredHeroes = heroes
            loadHeroCalled = true
        }
        
        func fetchHero() {
            _allHeroes = heroes
            _filteredHeroes = heroes
            fetchHeroCalled = true
        }
        
        func filterHeroWith(role: Role) {
            filterHeroCalled = true
        }
        
        func didSelectHeroAt(index: Int) {
            shouldShowHeroDetail = true
        }
    }
    
    // MARK: Testcases
    
    func testViewControllerShouldAskPresenterToLoadHeroWhenViewDidLoad() {
        // Given
        let mockPresenter = HeroListPresenterMock()
        sut = HeroListViewController(presenter: mockPresenter)
        
        // When
        loadView()
        sut.viewDidLoad()
        
        // Then
        XCTAssert(mockPresenter.loadHeroCalled)
    }
    
    func testViewControllerShouldAskPresenterToFetchHeroWhenViewDidLoad() {
        // Given
        let mockPresenter = HeroListPresenterMock()
        sut = HeroListViewController(presenter: mockPresenter)
        
        // When
        loadView()
        sut.viewDidLoad()
        
        // Then
        XCTAssert(mockPresenter.fetchHeroCalled)
    }
    
    func testViewControllerShouldAskPresenterToStartNetworkMonitoringWhenViewDidAppear() {
        // Given
        let mockPresenter = HeroListPresenterMock()
        sut = HeroListViewController(presenter: mockPresenter)
        
        // When
        loadView()
        sut.viewDidAppear(true)
        
        // Then
        XCTAssert(mockPresenter.startNetworkMonitoringCalled)
    }
    
    func testViewControllerShouldAskPresenterToStopNetworkMonitoringWhenViewWillDisAppear() {
        // Given
        let mockPresenter = HeroListPresenterMock()
        sut = HeroListViewController(presenter: mockPresenter)
        
        // When
        loadView()
        sut.viewWillDisappear(true)
        
        // Then
        XCTAssert(mockPresenter.stopNetworkMonitoringCalled)
    }
    
    func testViewControllerStateShouldBePopulatedIfSuccessGetHero() {
        // Given
        let mockPresenter = HeroListPresenterMock()
        sut = HeroListViewController(presenter: mockPresenter)
        
        // When
        loadView()
        sut.showHero()
        
        // Then
        XCTAssert(sut.state == .populated)
    }
    
    func testViewControllerStateShouldErrorIfFailedGetHero() {
        // Given
        let mockPresenter = HeroListPresenterMock()
        sut = HeroListViewController(presenter: mockPresenter)
        
        // When
        loadView()
        sut.showError()
        
        // Then
        XCTAssert(sut.state == .error)
    }
    
    func testNumberOfRowFromTableViewShouldOneIfStateIsError() {
        // Given
        let mockPresenter = HeroListPresenterMock()
        sut = HeroListViewController(presenter: mockPresenter)
        
        // When
        loadView()
        sut.showError()
        
        // Then
        XCTAssert(sut.tableView.numberOfRows(inSection: 0) == 1)
    }
    
    func testNumberOfRowFromTableViewShouldEqualToThreeIfStateIsPopulated() {
        // Given
        let mockPresenter = HeroListPresenterMock()
        sut = HeroListViewController(presenter: mockPresenter)
        
        // When
        loadView()
        sut.showHero()
        
        // Then
        XCTAssert(sut.tableView.numberOfRows(inSection: 0) == 3)
    }
}
