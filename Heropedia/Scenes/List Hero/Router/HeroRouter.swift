//
//  HeroRouter.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 17/02/21.
//

import UIKit

protocol HeroRouterDependencies {
    func createHeroListViewController(callback: HeroListPresenterCallback) -> HeroListViewController
    func createHeroDetailViewController(hero: Hero, similarHero: [Hero]) -> HeroDetailViewController
}

final class HeroRouter {
    
    private let dependency: HeroRouterDependencies
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController, dependency: HeroRouterDependencies) {
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    func startApp() {
        let callback = HeroListPresenterCallback(showHeroDetail: showHeroDetail)
        let viewController = dependency.createHeroListViewController(callback: callback)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showHeroDetail(hero: Hero, similarHero: [Hero]) {
        let viewController = dependency.createHeroDetailViewController(hero: hero, similarHero: similarHero)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
