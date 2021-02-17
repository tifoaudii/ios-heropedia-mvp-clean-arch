//
//  HeroSceneDIContainer.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 17/02/21.
//

import UIKit

final class HeroSceneDIContainer {
    
    // MARK:- Hero Router
    func createHeroRouter(navigationController: UINavigationController) -> HeroRouter {
        return HeroRouter(navigationController: navigationController, dependency: self)
    }
}

extension HeroSceneDIContainer: HeroRouterDependencies {
    func createHeroListViewController(callback: HeroListPresenterCallback) -> HeroListViewController {
        let service = NetworkService(
            dataStore: DefaultNetworkDataStore(),
            cacheRepository: DefaultNetworkCacheRepository()
        )
        
        
        let presenter = DefaultHeroListPresenter(service: service, callback: callback)
        let viewController = HeroListViewController(presenter: presenter)
        presenter.setViewController(viewController: viewController)
        
        return viewController
    }
    
    func createHeroDetailViewController(hero: Hero, similarHero: [Hero]) -> HeroDetailViewController {
        return HeroDetailViewController(hero: hero, similarHero: similarHero)
    }
}
