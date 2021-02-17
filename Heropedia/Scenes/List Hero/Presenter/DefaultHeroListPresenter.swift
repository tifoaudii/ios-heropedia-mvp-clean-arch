//
//  HeroListRepository.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 16/02/21.
//

import Foundation
import Reachability

public struct HeroListPresenterCallback {
    let showHeroDetail: (_ hero: Hero, _ similarHero: [Hero]) -> Void
}

public enum HeroDetailViewKind: CaseIterable {
    case name
    case type
    case attribute
    case health
    case maxAttack
    case speed
    case roles
}

protocol HeroListPresenter {
    var allHeroes: [Hero] { get }
    var filteredHeroes: [Hero] { get }
    var roles: [Role] { get }
    var selectedRole: Role { get }
    
    func startNetworkMonitoring()
    func stopNetworkMonitoring()
    func loadHero()
    func fetchHero()
    func filterHeroWith(role: Role)
    func didSelectHeroAt(index: Int)
}

final class DefaultHeroListPresenter: HeroListPresenter {
    
    // MARK:- Private properties
    private var _allHeroes: [Hero] = []
    private var _filteredHeroes: [Hero] = []
    private var _roles: [Role] = Role.allCases
    private var _selectedRole: Role = .all
    
    private weak var viewController: HeroListViewPresentationProtocol?
    private var reachability: Reachability?
    
    // MARK:- Dependency
    private let service: NetworkService
    private let callBack: HeroListPresenterCallback?
    
    // MARK:- Initializer
    init(service: NetworkService, callback: HeroListPresenterCallback? = nil) {
        self.service = service
        self.callBack = callback
    }
    
    // MARK:- Setter
    func setViewController(viewController: HeroListViewPresentationProtocol) {
        self.viewController = viewController
    }
    
    // MARK:- HeroListPresenter Implementation
    var allHeroes: [Hero] {
        return _allHeroes
    }
    
    var filteredHeroes: [Hero] {
        return _filteredHeroes
    }
    
    var roles: [Role] {
        return _roles
    }
    
    var selectedRole: Role {
        return _selectedRole
    }
    
    func fetchHero() {
        service.fetchHero { [weak self] (hero: [Hero]) in
            self?.populateData(hero: hero)
            self?.viewController?.showHero()
        } onFailure: { [weak self] (error: ErrorResponse) in
            self?.viewController?.showInternetConnectionProblemMessage()
        }
    }
    
    func loadHero() {
        service.loadHero { [weak self] (hero: [Hero]) in
            self?.populateData(hero: hero)
            self?.viewController?.showHero()
        } onFailure: { [weak self] (error: Error) in
            self?.viewController?.showError()
        }
    }
    
    func filterHeroWith(role: Role) {
        _selectedRole = role
        _filteredHeroes = _allHeroes.filter({ (hero: Hero) -> Bool in
            guard role != .all else {
                return true
            }
            
            return hero.roles.contains(role)
        })
        
        viewController?.reloadData()
    }
    
    func didSelectHeroAt(index: Int) {
        let selectedHero = _filteredHeroes[index]
        let similarHero = getSimilarHeroFrom(attribute: selectedHero.primaryAttr)
        callBack?.showHeroDetail(selectedHero, similarHero)
    }
    
    func startNetworkMonitoring() {
        reachability = try? Reachability()
        
        do { try? reachability?.startNotifier() }
        reachability?.whenUnreachable = { [weak self] _ in
            self?.viewController?.showInternetConnectionProblemMessage()
        }
    }
    
    func stopNetworkMonitoring() {
        reachability?.stopNotifier()
        reachability = nil
    }
    
    // MARK:- Private functions
    private func getSimilarHeroFrom(attribute: PrimaryAttr) -> [Hero] {
        switch attribute {
        case .agi:
            return getTopHighestMovementHeroes()
        case .int:
            return getTopHighestBaseManaHeroes()
        case .str:
            return getTopHighestBaseAttackMaxHeroes()
        }
    }
    
    private func getTopHighestMovementHeroes() -> [Hero] {
        return Array(_allHeroes.sorted(by: { $0.moveSpeed > $1.moveSpeed }).prefix(3))
    }
    
    private func getTopHighestBaseAttackMaxHeroes() -> [Hero] {
        return Array(_allHeroes.sorted(by: { $0.baseAttackMax > $1.baseAttackMax }).prefix(3))
    }
    
    private func getTopHighestBaseManaHeroes() -> [Hero] {
        return Array(_allHeroes.sorted(by: { $0.baseMana > $1.baseMana }).prefix(3))
    }
    
    private func populateData(hero: [Hero]) {
        _allHeroes = hero
        _filteredHeroes = hero
    }
}
