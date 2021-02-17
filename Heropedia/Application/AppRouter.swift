//
//  AppRouter.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 17/02/21.
//

import UIKit

final class AppRouter {
    
    private let navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let heroDIContainer = appDIContainer.createHeroSceneDIContainer()
        let router = heroDIContainer.createHeroRouter(navigationController: navigationController)
        router.startApp()
    }
}
