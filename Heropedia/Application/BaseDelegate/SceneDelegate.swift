//
//  SceneDelegate.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 12/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        
        let service = NetworkService(dataStore: DefaultNetworkDataStore(), cacheRepository: DefaultNetworkCacheRepository())
        let presenter = DefaultHeroListPresenter(service: service)
        let heroListVC = HeroListViewController(presenter: presenter)
        presenter.setViewController(viewController: heroListVC)
        
        let rootViewController = UINavigationController(rootViewController: heroListVC)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}

