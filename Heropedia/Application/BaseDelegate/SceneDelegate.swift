//
//  SceneDelegate.swift
//  Heropedia
//
//  Created by Tifo Audi Alif Putra on 12/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let appDIContainer = AppDIContainer()
    
    var window: UIWindow?
    var appRouter: AppRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        appRouter = AppRouter(navigationController: navigationController, appDIContainer: appDIContainer)
        appRouter?.start()
        window?.makeKeyAndVisible()
    }
}

